from flask import Blueprint, render_template, url_for, redirect, session, request
from flask_sqlalchemy import SQLAlchemy
from libs.user_permission import get_user_type_in_session
from libs.constant import UserTypeEnum
from models import User, Cart
import json
from libs.sql_action import safe_commit
from werkzeug.security import generate_password_hash, check_password_hash
from libs.user_permission import user_required
db = SQLAlchemy()
mod = Blueprint(name='authentication_client', import_name="__name__", url_prefix='/',
                static_folder='static/client/assets',
                template_folder='templates/client')


@mod.route('/login', methods=['GET', 'POST'])
def login():
    """Return welcome page for non-login user
               Step 1: Check user login, if login -> redirect to question list page
               Step 2: Compare email, password with DB object
           """
    user_type = get_user_type_in_session()
    if user_type == UserTypeEnum.USER_LOGIN:
        return redirect(url_for('main.main'))

    if request.method == 'POST':
        # read form data
        username = request.form.get('username')
        password = request.form.get('password')
        user_checked = db.session.query(User).filter(User.username == username).first()
        if not user_checked or not check_password_hash(user_checked.password, password):
            return json.dumps({'success': False, 'message': 'Không Có Tài Khoản hoặc mật khẩu sai, vui lòng kiểm tra'})
        else:
            session['user'] = username
            session['user_type'] = UserTypeEnum.USER_LOGIN
            session['user_id'] = user_checked.id
            session['user_avatar'] = user_checked.avatar_url if user_checked.avatar_url else ''
            return json.dumps({'success': True, 'message': 'Đăng Nhập Thành Công'})

    return render_template('login.html')


@mod.route('/register', methods=['GET', 'POST'])
def register():
    user_type = get_user_type_in_session()
    if user_type == UserTypeEnum.USER_LOGIN:
        return redirect(url_for('main.main'))

    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        email = request.form.get('email')

        # Check usename exists
        user = db.session.query(User).filter(User.username == username).first()
        if user:
            return json.dumps({'success': False, 'message': 'Username already registered'})

        # Check email exists
        user = db.session.query(User).filter(User.email == email).first()
        if user:
            return json.dumps({'success': False, 'message': 'Email already registered'})

        # else we can create the user
        new_user = User(email=email, username=username, password=generate_password_hash(password, method='sha256'))
        db.session.add(new_user)
        db.session.commit()
        cart = Cart(
            user_id=new_user.id
        )
        db.session.add(cart)
        db.session.commit()
        return json.dumps({'success': True, 'message': 'Đăng Ký Thành Công'})
    else:
        return render_template('register.html')


@mod.route('/logout')
@user_required
def logout():
    session.pop('user', None)
    session.pop('user_id', None)
    session.pop('user_type', None)
    session.pop('user_avatar', None)
    return redirect(url_for('main.main'))