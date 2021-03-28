from flask import Blueprint, render_template, redirect, url_for, request
from flask_login import login_required, current_user
from flask_sqlalchemy import SQLAlchemy

from common.constant import ROWS_PER_PAGE
from models import Staff

db = SQLAlchemy()
mod = Blueprint(name='staff_management', import_name="__name__", url_prefix='/admin',
                static_folder='static/admin/assets',
                template_folder='templates/admin')


@mod.route('/staff_management', methods=['GET'])
@login_required
def staff_management():
    page = request.args.get('page', 1, type=int)
    list_staff = db.session.query(Staff).paginate(page=page, per_page=ROWS_PER_PAGE)
    return render_template('staff_management.html', staffs=list_staff)


@mod.route('/staff_management/<id_staff>')
@login_required
def staff_detail(id_staff):
    if id_staff == 'add':
        return render_template('staff_detail.html', current_user=current_user, staff={})
    else:
        current_staff = db.session.query(Staff).filter(Staff.id == int(id_staff)).first()
        return render_template('staff_detail.html', current_user=current_user, staff=current_staff)


@mod.route('/staff_management/<id_staff>', methods=['DELETE'])
@login_required
def delete_staff_detail(id_staff):
    current_staff = db.session.query(Staff).filter(Staff.id == int(id_staff)).first()
    if current_staff:
        current_staff.is_deleted = True
        db.session.commit()
    return redirect(url_for('staff_management.staff_management'))
