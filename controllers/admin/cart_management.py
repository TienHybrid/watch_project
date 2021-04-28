from flask import Blueprint, render_template, request, current_app
from libs.user_permission import admin_required
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.dialects.postgresql import array
from models import User, Place, Cart, Cartproduct
import json
from sqlalchemy import or_, func
from service.cart import get_all_cart_by_cart_id
mod = Blueprint(name='cart_management', import_name="__name__", url_prefix='/admin',
                static_folder='static/admin/assets',
                template_folder='templates/admin')

db = SQLAlchemy()


def handle_create_or_update_cart(form, id_cart):
    """
    Get detail
    :param form:
    :param id_cart:
    :return:
    """
    name = form['name']
    short_name = form['short_name']
    if id_cart == 'add':
        cart = Cart(
            name=name,
            short_name=short_name
        )
        db.session.add(Cart)
    else:
        cart = db.session.query(Cart).filter_by(id=int(id_cart)).first()
        cart.name = name
        cart.short_name = short_name
        db.session.merge(cart)
    db.session.commit()
    return cart


@mod.route('/cart_management')
@admin_required
def cart_management():
    page = request.args.get('page', 1, type=int)
    search = request.args.get('search', None)
    user_cart = db.session.query(
        User.id.label('id'),
        User.avatar_url.label('avatar_url'),
        User.username.label('username'),
        User.fullname.label('fullname'),
        Cart.id.label('cart_id')
    ).join(Cart, Cart.user_id == User.id, full=True).filter(
        User.is_deleted.is_(False),
    ).all()
    list_cart = []
    for user in user_cart:
        list_cart.append({
            'avatar_url': user[1],
            'username': user[2],
            'fullname': user[3],
            'carts': get_all_cart_by_cart_id(user[4]) if user[4] else None
        })
    current_app.logger.info(list_cart)
    return render_template('cart_management.html', carts=list_cart)


@mod.route('/cart_management/<id_cart>', methods=['GET', 'POST'])
@admin_required
def cart_detail(id_cart):
    if request.method == 'POST':
        data = request.form
        cart = handle_create_or_update_cart(form=data, id_cart=id_cart)
        return json.dumps({'message': 'Successfully', 'id_cart': cart.id})
    else:
        if id_cart == 'add':
            return render_template('cart_detail.html', title='Thêm Mới cart', id_cart='add',
                                   cart={})
        else:
            current_cart = db.session.query(Cart).filter(Cart.id == int(id_cart),
                                                                 Cart.is_deleted.is_(False)).first()
            return render_template('cart_detail.html', title='Chỉnh Sửa cart', cart=current_cart,
                                   id_cart=id_cart)


@mod.route('/cart_management/delete/<id_cart>', methods=['POST'])
@admin_required
def delete_cart_detail(id_cart):
    current_cart = db.session.query(Cart).filter(Cart.id == int(id_cart),
                                                       Cart.is_deleted.is_(False)).first()
    if current_cart:
        current_cart.is_deleted = True
        db.session.commit()
    return 'Delete question successfully'