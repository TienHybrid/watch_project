from datetime import datetime

from flask_sqlalchemy import SQLAlchemy
from flask import current_app
from models import Cartproduct, Stock, Product, Stockinproduct, Place, Cart, Transaction ,Transactionproduct

db = SQLAlchemy()


def get_all_transaction_product_by_transaction_id(transaction_id):
    transaction_product = db.session.query(
        Transactionproduct.id.label('id'),
        Transactionproduct.quantity.label('quantity'),
        Stock.name.label('stock_name'),
        Stock.name.label('stock_id'),
        Place.id.label('place_id'),
        Place.name.label('place_name'),
        Product.name.label('product_name'),
        Product.price.label('product_price'),
    ).join(
        Stock, Stock.id == Transactionproduct.stock_id
    ).join(
        Place, Place.id == Stock.place_id
    ).join(
        Product, Product.id == Transactionproduct.product_id
    ).filter(
        Transactionproduct.transaction_id == transaction_id,
        Transactionproduct.is_deleted.is_(False),
    ).all()
    return transaction_product
