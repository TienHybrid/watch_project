from flask import Blueprint, render_template, redirect, url_for, request
from flask_sqlalchemy import SQLAlchemy
from common.constant import ROWS_PER_PAGE
from models import Staff
from libs.user_permission import admin_required
from libs.sql_action import safe_commit
from libs.upload import uploads_banner_image
from werkzeug.security import generate_password_hash
from config import STAFF_FOLDER
from sqlalchemy import or_

import json
db = SQLAlchemy()
mod = Blueprint(name='staff_management', import_name="__name__", url_prefix='/admin',
                static_folder='static/admin/assets',
                template_folder='templates/admin')


def handle_create_or_update_staff(form, id_staff, file):
    """
    Get detail
    :param form:
    :param id_staff:
    :param file:
    :return:
    """
    username = form['username']
    email = form['email']
    fullname = form['fullname']
    phone_number = form['phone_number']
    address = form['address']

    if id_staff == 'add':
        password = form['password']
        staff = Staff(
            username=username,
            email=email,
            fullname=fullname,
            phone_number=phone_number,
            address=address,
            avatar_url=[],
            password=generate_password_hash(password, method='sha256')
        )
        db.session.add(staff)
    else:
        staff = db.session.query(Staff).filter_by(id=int(id_staff)).first()
        staff.username = username
        staff.email = email
        staff.fullname = fullname
        staff.phone_number = phone_number
        staff.address = address
        db.session.merge(staff)
    db.session.commit()
    if len(file) > 0:
        url = uploads_banner_image(id=staff.id, file=file['file'], location=STAFF_FOLDER)
        db.session.query(Staff).filter_by(id=staff.id).update(dict(avatar_url=url))
        db.session.commit()
    return staff


@mod.route('/staff_management', methods=['GET'])
@admin_required
def staff_management():
    page = request.args.get('page', 1, type=int)
    search = request.args.get('search', None)
    list_staff = db.session.query(Staff).filter(Staff.is_deleted.is_(False))
    if search:
        list_staff = list_staff.filter(or_(Staff.username.like('%' + search + '%')))
    list_staff = list_staff.paginate(page=page, per_page=ROWS_PER_PAGE)

    return render_template('staff_management.html', staffs=list_staff)


@mod.route('/staff_management/<id_staff>', methods=['GET', 'POST'])
@admin_required
def staff_detail(id_staff):
    if request.method == 'POST':
        data = request.form

        staff = handle_create_or_update_staff(form=data, id_staff=id_staff, file=request.files)
        return json.dumps({'message': 'Successfully', 'id_staff': staff.id})
    else:
        if id_staff == 'add':
            return render_template('staff_detail.html', title='Thêm Mới Nhân Viên', id_staff='add', staff={})
        else:
            current_staff = db.session.query(Staff).filter(Staff.id == int(id_staff),
                                                           Staff.is_deleted.is_(False)).first()
            return render_template('staff_detail.html', title='Chỉnh Sửa Nhân Viên', staff=current_staff,
                                   id_staff=id_staff)


@mod.route('/staff_management/delete/<id_staff>',methods=['POST'])
@admin_required
def delete_staff_detail(id_staff):
    current_staff = db.session.query(Staff).filter(Staff.id == int(id_staff), Staff.is_deleted.is_(False)).first()
    if current_staff:
        current_staff.is_deleted = True
        db.session.commit()
    return 'Delete question successfully'
