from flask import Blueprint, render_template, request
from libs.user_permission import admin_required
from flask_sqlalchemy import SQLAlchemy
from models import Brand
from common.constant import ROWS_PER_PAGE
import json
from libs.upload import uploads_banner_image
from config import BRAND_FOLDER
from sqlalchemy import or_

mod = Blueprint(name='brand_management', import_name="__name__", url_prefix='/admin',
                static_folder='static/admin/assets',
                template_folder='templates/admin')

db = SQLAlchemy()


def handle_create_or_update_brand(form, id_brand, file):
    """
    Get detail
    :param form:
    :param id_brand:
    :param file:
    :return:
    """
    name = form['name']

    if id_brand == 'add':
        brand = Brand(
            name=name,
            image_url='',
        )
        db.session.add(brand)
    else:
        brand = db.session.query(Brand).filter_by(id=int(id_brand)).first()
        brand.name = name
        db.session.merge(brand)
    db.session.commit()
    if len(file) > 0:
        url = uploads_banner_image(id=brand.id, file=file['file'], location=BRAND_FOLDER)
        db.session.query(Brand).filter_by(id=brand.id).update(dict(image_url=url))
        db.session.commit()
    return brand


@mod.route('/brand_management')
@admin_required
def brand_management():
    page = request.args.get('page', 1, type=int)
    search = request.args.get('search', None)
    list_brand = db.session.query(Brand).filter(Brand.is_deleted.is_(False))
    if search:
        list_brand = list_brand.filter(or_(Brand.name.like('%' + search + '%')))

    list_brand = list_brand.paginate(page=page, per_page=ROWS_PER_PAGE)
    return render_template('brand_management.html', brands=list_brand)


@mod.route('/brand_management/<id_brand>', methods=['GET', 'POST'])
@admin_required
def brand_detail(id_brand):
    if request.method == 'POST':
        data = request.form
        staff = handle_create_or_update_brand(form=data, id_brand=id_brand, file=request.files)
        return json.dumps({'message': 'Successfully', 'id_brand': staff.id})
    else:
        if id_brand == 'add':
            return render_template('brand_detail.html', title='Thêm Mới Loại Thương Hiệu', id_brand='add',
                                   brand={})
        else:
            current_brand = db.session.query(Brand).filter(Brand.id == int(id_brand),
                                                                 Brand.is_deleted.is_(False)).first()
            return render_template('brand_detail.html', title='Chỉnh Sửa Loại Thương Hiệu', brand=current_brand,
                                   id_brand=id_brand)


@mod.route('/brand_management/delete/<id_brand>', methods=['POST'])
@admin_required
def delete_brand_detail(id_brand):
    current_brand = db.session.query(Brand).filter(Brand.id == int(id_brand),
                                                       Brand.is_deleted.is_(False)).first()
    if current_brand:
        current_brand.is_deleted = True
        db.session.commit()
    return 'Delete brand successfully'