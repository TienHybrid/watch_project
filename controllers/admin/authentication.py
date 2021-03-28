from flask import Blueprint, render_template, request, redirect, url_for, current_app
from flask_login import login_user
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import login_required, current_user, logout_user
from models import Staff
from templates.admin.forms import LoginForm, CreateAccountForm

mod = Blueprint(name='authentication', import_name="__name__", url_prefix='/admin', static_folder='static/admin/assets',
                template_folder='templates/admin')
db = SQLAlchemy()


## Login & Registration

@mod.route('/login', methods=['GET', 'POST'])
def login():
    login_form = LoginForm(request.form)
    if 'login' in request.form:
        # read form data
        username = request.form.get('username')
        password = request.form.get('password')
        remember = True if request.form.get('remember') else False

        # Locate user
        staff_checked = db.session.query(Staff).filter(Staff.username == username).first()

        if not staff_checked or not check_password_hash(staff_checked.password, password):
            current_app.logger.info(f'{staff_checked}')
            return render_template('accounts/login.html', msg='Không Có User hoặc mật khẩu sai, vui lòng kiểm tra',
                                   form=login_form)
        else:
            login_user(staff_checked, remember=remember)
            return redirect(url_for('admin.admin'))
    return render_template('accounts/login.html', form=login_form)


@mod.route('/register', methods=['GET', 'POST'])
def register():
    create_account_form = CreateAccountForm(request.form)
    if 'register' in request.form:
        username = request.form['username']
        email = request.form['email']
        password = request.form['password']
        # Check usename exists
        user = db.session.query(Staff).filter(Staff.username == username).first()
        if user:
            return render_template('accounts/register.html',
                                   msg='Username already registered',
                                   success=False,
                                   form=create_account_form)

        # Check email exists
        user = db.session.query(Staff).filter(Staff.email == email).first()
        if user:
            return render_template('accounts/register.html',
                                   msg='Email already registered',
                                   success=False,
                                   form=create_account_form)

        # else we can create the user
        new_user = Staff(email=email, username=username, password=generate_password_hash(password, method='sha256'))
        db.session.add(new_user)
        db.session.commit()
        return render_template('accounts/register.html',
                               msg='User created please <a href="./login">login</a>',
                               success=True,
                               form=create_account_form)

    else:
        return render_template('accounts/register.html', form=create_account_form)


@mod.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('authentication.login'))


@mod.route('/profile')
@login_required
def profile():
    return render_template('profile.html', current_user=current_user)


@mod.errorhandler(403)
def access_forbidden(error):
    return render_template('page-403.html'), 403


@mod.errorhandler(404)
def not_found_error(error):
    return render_template('page-404.html'), 404


@mod.errorhandler(500)
def internal_error(error):
    return render_template('page-500.html'), 500
