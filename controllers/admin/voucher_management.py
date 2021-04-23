import json

from flask import Blueprint, render_template, request
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import or_
from config import VOUCHER_TYPE
from common.constant import ROWS_PER_PAGE
from libs.user_permission import admin_required
from models import Voucher

mod = Blueprint(name='voucher_management', import_name="__name__", url_prefix='/admin',
                static_folder='static/admin/assets',
                template_folder='templates/admin')

db = SQLAlchemy()


def handle_create_or_update_voucher(form, id_voucher):
    """
    Get detail
    :param form:
    :param id_voucher:
    :param file:
    :return:
    """
    name = form['name']
    code = form['code']
    type = form['type']
    begin_date = form['begin_date']
    end_date = form['end_date']
    discount = form['discount']

    if id_voucher == 'add':
        voucher = Voucher(
            name=name,
            code=code,
            type=type,
            begin_date=begin_date,
            end_date=end_date,
            discount=discount
        )
        db.session.add(voucher)
    else:
        voucher = db.session.query(Voucher).filter_by(id=int(id_voucher)).first()
        voucher.name = name
        voucher.code = code
        voucher.type = type
        voucher.begin_date = begin_date
        voucher.end_date = end_date
        voucher.discount = discount
        db.session.merge(voucher)
    db.session.commit()
    return voucher


@mod.route('/voucher_management')
@admin_required
def voucher_management():
    page = request.args.get('page', 1, type=int)
    search = request.args.get('search', None)
    list_voucher = db.session.query(Voucher).filter(Voucher.is_deleted.is_(False))
    if search:
        list_voucher = list_voucher.filter(or_(Voucher.name.like('%' + search + '%')))

    list_voucher = list_voucher.paginate(page=page, per_page=ROWS_PER_PAGE)
    return render_template('voucher_management.html', vouchers=list_voucher)


@mod.route('/voucher_management/<id_voucher>', methods=['GET', 'POST'])
@admin_required
def voucher_detail(id_voucher):
    if request.method == 'POST':
        data = request.form
        voucher = handle_create_or_update_voucher(form=data, id_voucher=id_voucher)
        return json.dumps({'message': 'Successfully', 'id_voucher': voucher.id})
    else:
        if id_voucher == 'add':
            return render_template('voucher_detail.html', title='Thêm Mới Voucher', id_voucher='add',
                                   voucher_type=VOUCHER_TYPE,
                                   voucher={})
        else:
            current_voucher = db.session.query(Voucher).filter(Voucher.id == int(id_voucher),
                                                                 Voucher.is_deleted.is_(False)).first()
            return render_template('voucher_detail.html', title='Chỉnh Sửa Voucher', voucher=current_voucher,
                                   voucher_type=VOUCHER_TYPE,
                                   id_voucher=id_voucher)

@mod.route('/voucher_management/active/<id_voucher>', methods=['POST'])
@admin_required
def active_voucher_detail(id_voucher):
    current_voucher = db.session.query(Voucher).filter(Voucher.id == int(id_voucher),
                                                         Voucher.is_deleted.is_(False)).first()
    if current_voucher:
        current_voucher.active = True if current_voucher.active == False else True
        db.session.commit()
    return 'Active Voucher successfully'

@mod.route('/voucher_management/delete/<id_voucher>', methods=['POST'])
@admin_required
def delete_voucher_detail(id_voucher):
    current_voucher = db.session.query(Voucher).filter(Voucher.id == int(id_voucher),
                                                         Voucher.is_deleted.is_(False)).first()
    if current_voucher:
        current_voucher.is_deleted = True
        db.session.commit()
    return 'Delete question successfully'
