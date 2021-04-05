from flask import Blueprint, render_template, request
from libs.user_permission import admin_required
from flask_sqlalchemy import SQLAlchemy
from models import Product, Category
from common.constant import ROWS_PER_PAGE
from libs.upload import uploads_banner_image
from config import PRODUCT_FOLDER
import re
import json

mod = Blueprint(name='product_management', import_name="__name__", url_prefix='/admin',
                static_folder='static/admin/assets',
                template_folder='templates/admin')

db = SQLAlchemy()


def is_valid_url(url):
    # Regex to check valid URL
    regex = ("((http|https)://)(www.)?" +
             "[a-zA-Z0-9@:%._\\+~#?&//=]" +
             "{2,256}\\.[a-z]" +
             "{2,6}\\b([-a-zA-Z0-9@:%" +
             "._\\+~#?&//=]*)")

    # Compile the ReGex
    p = re.compile(regex)

    # If the string is empty
    # return false
    try:
        if (url == None):
            return False

        # Return if the string
        # matched the ReGex
        if (re.search(p, url)):
            return True
    except:
        return False


def check_image_url(urls):
    invalid_urls = []
    valid_urls = []
    for url in urls:
        if is_valid_url(url):
            valid_urls.append(url)
        else:
            invalid_urls.append(url)

    return {
        'invalid_urls': invalid_urls,
        'valid_urls': valid_urls
    }


def upload_multiple_file(id, urls, location):
    uploaded_urls = []
    if not urls:
        return uploaded_urls
    else:
        for url in urls:
            data_url = uploads_banner_image(id=id, file=url, location=location)
            uploaded_urls.append(data_url)
        return uploaded_urls


def handle_create_or_update_product(form, id_product):
    """
    Get detail
    :param form:
    :param id_product:
    :return:
    """
    name = form['name']
    price = form['price']
    quantity = form['quantity']
    slug = form['slug']
    category_id = form['category_id']
    image_url = form['image_url']
    if id_product == 'add':
        product = Product(
            name=name,
            price=price,
            quantity=quantity,
            slug=slug,
            category_id=category_id,
            image_url=''
        )
        db.session.add(product)
    else:
        product = db.session.query(Product).filter_by(id=int(id_product)).first()
        product.name = name
        product.price = price
        product.quantity = quantity
        product.slug = slug
        product.category_id = category_id
        db.session.merge(product)
    db.session.commit()
    if len(image_url) > 0:
        array_parse = json.loads(image_url)
        urls = check_image_url(array_parse)
        uploaded_urls = upload_multiple_file(id=product.id, urls=urls['invalid_urls'], location=PRODUCT_FOLDER)
        db.session.query(Product).filter_by(id=product.id).update(image_url=urls['valid_urls'] + uploaded_urls)
        db.session.commit()
    return product


@mod.route('/product_management')
@admin_required
def product_management():
    page = request.args.get('page', 1, type=int)
    list_product = db.session.query(Product).filter(Product.is_deleted.is_(False)).paginate(page=page,
                                                                                            per_page=ROWS_PER_PAGE)
    return render_template('product_management.html', products=list_product)


@mod.route('/product_management/<id_product>', methods=['GET', 'POST'])
@admin_required
def product_detail(id_product):
    if request.method == 'POST':
        data = request.form
        uploaded_files = request.files.getlist("image_url")

        product = handle_create_or_update_product(form=data, id_product=id_product)
        return json.dumps({'message': 'Successfully', 'id_product': product.id})
    else:
        list_category = db.session.query(Category).filter(Category.is_deleted.is_(False))
        if id_product == 'add':
            return render_template('product_detail.html',
                                   title='Thêm Mới Sản Phẩm',
                                   id_product='add',
                                   categories=list_category,
                                   product={})
        else:
            current_product = db.session.query(Product).filter(Product.id == int(id_product),
                                                               Product.is_deleted.is_(False)).first()
            return render_template('product_detail.html',
                                   title='Chỉnh Sửa Sản Phẩm',
                                   product=current_product,
                                   categories=list_category,
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
