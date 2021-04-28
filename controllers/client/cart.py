from flask import Blueprint, render_template, g
from models import Category, Voucher
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()
mod = Blueprint(name='cart', import_name="__name__", url_prefix='/', static_folder='static/client/assets',
                template_folder='templates/client')


@mod.route('/cart', methods=['GET'])
def cart():
    category = db.session.query(Category).all()
    list_cart = g.carts
    list_voucher = db.session.query(Voucher).filter(Voucher.is_deleted.is_(False))
    return render_template('cart.html', category=category, carts =list_cart, vouchers=list_voucher)


@mod.route('/checkout', methods=['GET'])
def checkout():
    category = db.session.query(Category).all()
    return render_template('checkout.html', category=category)