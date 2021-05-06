# ----------------------------------------------------------------------------#
# Imports
# ----------------------------------------------------------------------------#

import logging
from logging import Formatter, FileHandler

from flask import Flask, session, current_app, g
from flask_sqlalchemy import SQLAlchemy
from libs.sql_action import db
from controllers.admin import admin, product_management, user_management, category_management, \
    staff_management, authentication_admin, place_management, voucher_management, stock_management, cart_management, \
    brand_management, order_management, guarantee_management
from controllers.client import main, product, cart, authentication_client, order
from libs.constant import none_to_empty_string
from models import Place, Category, Cart, Brand, Placemaster, Voucher, Voucherinuser
from libs.user_permission import user_required
from service.cart import get_cart_by_cart_id_and_user_id
from libs.constant import UserTypeEnum
from config import NO_BRAND_ID, SHIPPING_FEE
from service.voucher import get_all_voucher
from datetime import datetime

import json


# ----------------------------------------------------------------------------#
# App Config.
# ----------------------------------------------------------------------------#


def create_app():
    my_app = Flask(__name__)
    my_app.config.from_object('config')
    my_app.register_blueprint(main.mod)
    my_app.register_blueprint(cart.mod)
    my_app.register_blueprint(product.mod)
    my_app.register_blueprint(admin.mod)
    my_app.register_blueprint(authentication_admin.mod)
    my_app.register_blueprint(product_management.mod)
    my_app.register_blueprint(staff_management.mod)
    my_app.register_blueprint(place_management.mod)
    my_app.register_blueprint(order.mod)
    my_app.register_blueprint(guarantee_management.mod)
    my_app.register_blueprint(order_management.mod)
    my_app.register_blueprint(brand_management.mod)
    my_app.register_blueprint(cart_management.mod)
    my_app.register_blueprint(voucher_management.mod)
    my_app.register_blueprint(stock_management.mod)
    my_app.register_blueprint(category_management.mod)
    my_app.register_blueprint(user_management.mod)
    my_app.register_blueprint(authentication_client.mod)
    # init database
    db_base = SQLAlchemy(my_app)
    db_base.init_app(my_app)
    return my_app


app = create_app()
app.jinja_env.globals.update(none_to_empty_string=none_to_empty_string)


@app.before_request
def get_location_data():
    list_place = db.session.query(Place).filter(Place.is_deleted.is_(False)).all()
    g.places = list_place
    if g.places and len(g.places) > 0 and not session.get('place_id', None):
        session['place_id'] = g.places[0].id


@app.before_request
def get_cart_product_data():
    if session.get('user_id', None):
        cart = db.session.query(Cart).filter(Cart.user_id == session['user_id']).first()
        if cart:
            list_cart = get_cart_by_cart_id_and_user_id(
                cart_id=cart.id,
                user_id=session['user_id'],
            )
            g.carts = list_cart
    else:
        g.carts = []


@app.before_request
def get_category():
    list_category = db.session.query(Category).filter(Category.is_deleted.is_(False)).all()
    g.categories = list_category

@app.before_request
def get_list_place():
    list_place = db.session.query(Placemaster).filter(Placemaster.is_deleted.is_(False)).all()
    g.list_place = list_place


@app.before_request
def get_brand():
    list_brand = db.session.query(Brand).filter(Brand.is_deleted.is_(False), Brand.id != NO_BRAND_ID).all()
    g.brands = list_brand

@app.before_request
def get_voucher_user():
    list_voucher_user = []
    list_voucher_all_user = get_all_voucher(type="all_user", limit=3)
    if session['user_id']:
        list_voucher_user = db.session.query(Voucher).join(
            Voucherinuser, Voucherinuser.voucher_id == Voucher.id
        ).filter(
            Voucherinuser.is_deleted.is_(False),
            Voucherinuser.user_id == session['user_id'],
            Voucher.begin_date <= datetime.now(),
            Voucher.end_date >= datetime.now(),
        ).all()
    g.shipping_fee = SHIPPING_FEE
    g.voucher_users = list_voucher_user + list_voucher_all_user

@app.after_request
def finish_request(response):
    """Close transaction after request"""
    db.session.close()
    return response


@app.template_filter()
def priceFormat(value):
    return format(int(value), ',d')


if not app.debug:
    file_handler = FileHandler('error.log')
    file_handler.setFormatter(
        Formatter('%(asctime)s %(levelname)s: %(message)s [in %(pathname)s:%(lineno)d]')
    )
    app.logger.setLevel(logging.INFO)
    file_handler.setLevel(logging.INFO)
    app.logger.addHandler(file_handler)
    app.logger.info('errors')

# ----------------------------------------------------------------------------#
# Launch.
# ----------------------------------------------------------------------------#

# Default port:
if __name__ == '__main__':
    app.run(debug=True)
