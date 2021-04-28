from flask import Blueprint, render_template, session, redirect, url_for, request
from models import Category, User, Voucher
from flask_sqlalchemy import SQLAlchemy
from libs.user_permission import user_required
import json
from libs.upload import uploads_banner_image
from werkzeug.security import generate_password_hash ,check_password_hash
from config import USER_FOLDER
from service.voucher import get_all_voucher
from  libs.upload import random_pwd
db = SQLAlchemy()
mod = Blueprint(name='main', import_name="__name__", url_prefix='/', static_folder='static/client/assets',
                template_folder='templates/client')


def update_user(form, id_user, file):
    """
    Get detail
    :param form:
    :param id_user:
    :param file:
    :return:
    """
    username = form['username']
    email = form['email']
    fullname = form['fullname']
    phone_number = form['phone_number']
    address = form['address']

    if id_user:
        user = db.session.query(User).filter_by(id=int(id_user)).first()
        user.username = username
        user.email = email
        user.fullname = fullname
        user.phone_number = phone_number
        user.address = address
        db.session.merge(user)
    db.session.commit()
    if len(file) > 0:
        url = uploads_banner_image(id=user.id, file=file['file'], location=USER_FOLDER)
        db.session.query(User).filter_by(id=user.id).update(dict(avatar_url=url))
        db.session.commit()
    return user


@mod.route('/')
def main():
    category = db.session.query(Category).all()
    list_voucher = get_all_voucher(type="all_user", limit=3)

    return render_template('client.html', category=category, vouchers=list_voucher)


@mod.route('/change-location/<id_location>')
def change_location(id_location):
    if id_location:
        session['place_id'] = int(id_location)
    return 'Done'

@mod.route('/profile', methods=['GET', 'POST'])
@user_required
def profile():
    user_id = session.get('user_id', None)
    if not user_id:
        return redirect(url_for('main.main'))
    user = db.session.query(User).filter(User.id == user_id).first()
    if user:
        if request.method == 'POST':
            data = request.form
            user = update_user(form=data, id_user=user_id, file=request.files)
            return json.dumps({'message': 'Successfully', 'success': True, 'id_user': user.id})
    return render_template('profile.html', current_user=user)


@mod.route('/change-pwd', methods=['POST'])
@user_required
def change_pwd():
    user_id = session.get('user_id', None)
    if not user_id:
        return redirect(url_for('main.main'))
    user = db.session.query(User).filter(User.id == user_id).first()
    if user:
        if request.method == 'POST':
            old_password = request.form['oldPassword']
            new_password = request.form['newPassword']
            if not check_password_hash(user.password, old_password):
                return json.dumps({'message': 'Mật khẩu cũ không khớp', 'success': False, 'id_user': user.id})
            user.password = generate_password_hash(new_password, method='sha256')
            db.session.merge(user)
            db.session.commit()
            return json.dumps({'message': 'Successfully', 'success': True, 'id_user': user.id})
    return render_template('profile.html', current_user=user)


@mod.route('/reset-pwd', methods=['POST'])
def reset_pwd():
    user_id = session.get('user_id', None)
    if not user_id:
        return redirect(url_for('main.main'))
    pwd = random_pwd()
    user = db.session.query(User).filter(User.id == user_id).first()
    if user:
        if request.method == 'POST':
            hash_pwd = generate_password_hash(pwd, method='sha256')
            db.session.query(User).filter_by(id=user_id).update(dict(hash_pwd=hash_pwd))
            db.session.commit()
    return json.dumps({'status': True, 'message': 'Update account successfully', 'password': pwd})