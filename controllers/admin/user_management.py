from flask import Blueprint, render_template, request
from flask_sqlalchemy import SQLAlchemy
from common.constant import ROWS_PER_PAGE
from sqlalchemy import or_

from models import User
from libs.user_permission import admin_required
from libs.upload import uploads_banner_image
from werkzeug.security import generate_password_hash
from config import USER_FOLDER
import json

mod = Blueprint(name='user_management', import_name="__name__", url_prefix='/admin',
                static_folder='static/admin/assets',
                template_folder='templates/admin')
db = SQLAlchemy()


def handle_create_or_update_user(form, id_user, file):
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

    if id_user == 'add':
        password = form['password']
        user = User(
            username=username,
            email=email,
            fullname=fullname,
            phone_number=phone_number,
            address=address,
            avatar_url='',
            password=generate_password_hash(password, method='sha256')
        )
        db.session.add(user)
    else:
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


@mod.route('/user_management', methods=['GET'])
@admin_required
def user_management():
    page = request.args.get('page', 1, type=int)
    search = request.args.get('search', None)
    list_user = db.session.query(User).filter(User.is_deleted.is_(False))

    if search:
        list_user = list_user.filter(or_(User.username.like('%' + search + '%')))
    list_user = list_user.paginate(page=page, per_page=ROWS_PER_PAGE)

    return render_template('user_management.html', users=list_user)


@mod.route('/user_management/<id_user>', methods=['GET', 'POST'])
@admin_required
def user_detail(id_user):
    if request.method == 'POST':
        data = request.form
        user = handle_create_or_update_user(form=data, id_user=id_user, file=request.files)
        return json.dumps({'message': 'Successfully', 'id_user': user.id})
    else:
        if id_user == 'add':
            return render_template('user_detail.html', title='Thêm Mới Người Dùng', id_user='add', user={})
        else:
            current_user = db.session.query(User).filter(User.id == int(id_user),
                                                         User.is_deleted.is_(False)).first()
            return render_template('user_detail.html', title='Chỉnh Sửa Người Dùng', user=current_user,
                                   id_user=id_user)


@mod.route('/user_management/delete/<id_user>', methods=['POST'])
@admin_required
def delete_user_detail(id_user):
    current_user = db.session.query(User).filter(User.id == int(id_user), User.is_deleted.is_(False)).first()
    if current_user:
        current_user.is_deleted = True
        db.session.commit()
    return 'Delete question successfully'
