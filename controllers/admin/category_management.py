from flask import Blueprint, render_template, request
from libs.user_permission import admin_required
from flask_sqlalchemy import SQLAlchemy
from models import Category
from common.constant import ROWS_PER_PAGE
import json
from libs.upload import uploads_banner_image
from config import CATEGORY_FOLDER
from sqlalchemy import or_

mod = Blueprint(name='category_management', import_name="__name__", url_prefix='/admin',
                static_folder='static/admin/assets',
                template_folder='templates/admin')

db = SQLAlchemy()


def handle_create_or_update_category(form, id_category, file):
    """
    Get detail
    :param form:
    :param id_category:
    :param file:
    :return:
    """
    name = form['name']

    if id_category == 'add':
        category = Category(
            name=name,
            image_url='',
        )
        db.session.add(category)
    else:
        category = db.session.query(Category).filter_by(id=int(id_category)).first()
        category.name = name
        db.session.merge(category)
    db.session.commit()
    if len(file) > 0:
        url = uploads_banner_image(id=category.id, file=file['file'], location=CATEGORY_FOLDER)
        db.session.query(Category).filter_by(id=category.id).update(dict(image_url=url))
        db.session.commit()
    return category


@mod.route('/category_management')
@admin_required
def category_management():
    page = request.args.get('page', 1, type=int)
    search = request.args.get('search', None)
    list_category = db.session.query(Category).filter(Category.is_deleted.is_(False))
    if search:
        list_category = list_category.filter(or_(Category.name.like('%' + search + '%')))

    list_category = list_category.paginate(page=page, per_page=ROWS_PER_PAGE)
    return render_template('category_management.html', categories=list_category)


@mod.route('/category_management/<id_category>', methods=['GET', 'POST'])
@admin_required
def category_detail(id_category):
    if request.method == 'POST':
        data = request.form
        staff = handle_create_or_update_category(form=data, id_category=id_category, file=request.files)
        return json.dumps({'message': 'Successfully', 'id_category': staff.id})
    else:
        if id_category == 'add':
            return render_template('category_detail.html', title='Thêm Mới Loại Sản Phẩm', id_category='add',
                                   category={})
        else:
            current_category = db.session.query(Category).filter(Category.id == int(id_category),
                                                                 Category.is_deleted.is_(False)).first()
            return render_template('category_detail.html', title='Chỉnh Sửa Loại Sản Phẩm', category=current_category,
                                   id_category=id_category)


@mod.route('/category_management/delete/<id_category>', methods=['POST'])
@admin_required
def delete_category_detail(id_category):
    current_category = db.session.query(Category).filter(Category.id == int(id_category),
                                                       Category.is_deleted.is_(False)).first()
    if current_category:
        current_category.is_deleted = True
        db.session.commit()
    return 'Delete question successfully'