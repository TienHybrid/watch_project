from datetime import datetime

from flask_sqlalchemy import SQLAlchemy

from models import Cartproduct, Stock, Product, Stockinproduct, Place, Cart

db = SQLAlchemy()


def get_all_cart_by_cart_id(cart_id):
    order_user = db.session.query(
        Cartproduct.id.label('id'),
        Cartproduct.quantity.label('quantity'),
        Stock.name.label('stock_name'),
        Product.name.label('product_name'),
        Product.price.label('product_price'),
    ).join(
        Stock, Stock.id == Cartproduct.stock_id
    ).join(
        Product, Product.id == Cartproduct.product_id
    ).filter(
        Cartproduct.cart_id == cart_id,
        Cartproduct.is_deleted.is_(False),
    ).all()
    return order_user

def get_cart_by_cart_id_and_user_id(cart_id, user_id, place_id):
    order_user = db.session.query(
        Cartproduct.id.label('id'),
        Cartproduct.quantity.label('quantity'),
        Stock.name.label('stock_name'),
        Product.name.label('product_name'),
        Product.image_url.label('image_url'),
        Product.price.label('product_price'),
        Product.id.label('product_id'),
    ).join(
        Stock, Stock.id == Cartproduct.stock_id
    ).join(
        Product, Product.id == Cartproduct.product_id
    ).join(
        Cart, Cart.id == Cartproduct.cart_id
    ).filter(
        Cartproduct.cart_id == cart_id,
        Cart.user_id == user_id,
        Cartproduct.is_deleted.is_(False),
        Stock.place_id == place_id
    ).all()
    return order_user
