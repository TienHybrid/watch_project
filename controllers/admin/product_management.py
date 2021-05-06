from flask import Blueprint, render_template, request
from libs.user_permission import admin_required
from flask_sqlalchemy import SQLAlchemy
from models import Product, Category, Stock, Stockinproduct, Place, Brand
from common.constant import ROWS_PER_PAGE
from libs.upload import uploads_banner_image
from config import PRODUCT_FOLDER
import json
from sqlalchemy import or_

mod = Blueprint(name='product_management', import_name="__name__", url_prefix='/admin',
                static_folder='static/admin/assets',
                template_folder='templates/admin')

db = SQLAlchemy()


def upload_multiple_file(id_selected, urls, location):
    uploaded_urls = []
    if not urls:
        return uploaded_urls
    else:
        for url in urls:
            data_url = uploads_banner_image(id=id_selected, file=url, location=location)
            uploaded_urls.append(data_url)
        return uploaded_urls


def handle_create_or_update_product(form, id_product, files):
    """
    Get detail
    :param form:
    :param id_product:
    :files files uploads
    :return:
    """
    name = form['name']
    old_price = form['old_price']
    price = form['price']
    slug = form['slug']
    category_id = form['category_id']
    brand_id = form['brand_id']
    image_url = form.get('image_url', [])
    if id_product == 'add':
        product = Product(
            name=name,
            price=price,
            old_price=old_price,
            slug=slug,
            category_id=category_id,
            brand_id=brand_id,
            image_url=[]
        )
        db.session.add(product)
    else:
        product = db.session.query(Product).filter_by(id=int(id_product)).first()
        product.name = name
        product.price = price
        product.old_price = old_price
        product.slug = slug
        product.category_id = category_id
        product.brand_id = brand_id
        db.session.merge(product)
    db.session.commit()
    uploaded_urls = []
    contain_files = []
    if len(files) > 0:
        uploaded_urls = upload_multiple_file(id_selected=product.id, urls=files, location=PRODUCT_FOLDER)
    if len(image_url) > 0:
        contain_files = json.loads(image_url)
    db.session.query(Product).filter_by(id=product.id).update(dict(image_url=uploaded_urls + contain_files))
    db.session.commit()
    return product


@mod.route('/product_management')
@admin_required
def product_management():
    page = request.args.get('page', 1, type=int)
    search = request.args.get('search')
    list_product = db.session.query(Product, Category.name.label('category_name'), Brand.name.label('brand_name')) \
        .join(Category, Category.id == Product.category_id)\
        .join(Brand, Brand.id == Product.brand_id)\
        .filter(
        Product.is_deleted.is_(False))
    if search:
        list_product = list_product.filter(or_(Product.name.like('%' + search + '%')))
    list_product = list_product.order_by(Product.updated_at.desc()).paginate(page=page, per_page=ROWS_PER_PAGE)
    return render_template('product_management.html', products=list_product)


@mod.route('/product_management/<id_product>', methods=['GET', 'POST'])
@admin_required
def product_detail(id_product):
    if request.method == 'POST':
        data = request.form
        uploaded_files = request.files.getlist("files")
        product = handle_create_or_update_product(form=data, id_product=id_product, files=uploaded_files)
        return json.dumps({'message': 'Successfully', 'id_product': product.id})
    else:
        list_category = db.session.query(Category).filter(Category.is_deleted.is_(False))
        list_brand = db.session.query(Brand).filter(Brand.is_deleted.is_(False))
        if id_product == 'add':
            return render_template('product_detail.html',
                                   title='Thêm Mới Sản Phẩm',
                                   id_product='add',
                                   categories=list_category,
                                   brands=list_brand,
                                   stocks=[],
                                   product={})
        else:
            current_product = db.session.query(Product).filter(Product.id == int(id_product),
                                                               Product.is_deleted.is_(False)).first()
            if current_product:
                list_stock = db.session.query(Stockinproduct.id.label('id'),
                                              Place.name.label('place'),
                                              Stockinproduct.quantity.label('quantity'),
                                              Stock.name.label('stock_name')).join(
                    Stock, Stock.id == Stockinproduct.stock_id
                ).join(Place, Place.id == Stock.place_id).filter(
                    Stockinproduct.product_id == current_product.id,
                    Stockinproduct.is_deleted.is_(False),
                    Stock.is_deleted.is_(False),
                    Place.is_deleted.is_(False)
                )
            return render_template('product_detail.html',
                                   title='Chỉnh Sửa Sản Phẩm',
                                   product=current_product,
                                   categories=list_category,
                                   brands=list_brand,
                                   stocks=list_stock,
                                   id_product=id_product)


@mod.route('/product_management/delete/<id_product>', methods=['POST'])
@admin_required
def delete_user_detail(id_product):
    current_product = db.session.query(Product).filter(Product.id == int(id_product),
                                                       Product.is_deleted.is_(False)).first()
    if current_product:
        current_product.is_deleted = True
        db.session.commit()
    return 'Delete question successfully'
