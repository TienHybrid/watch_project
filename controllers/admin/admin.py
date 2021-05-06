from flask import Blueprint, render_template, current_app
from libs.user_permission import admin_required
from flask_sqlalchemy import SQLAlchemy
from models import Transaction, User, Stockinproduct
from sqlalchemy.sql import func, extract
from libs.constant import ORDER_TYPE
from datetime import datetime

db = SQLAlchemy()

mod = Blueprint(name='admin', import_name="__name__", url_prefix='/admin', static_folder='static/admin/assets',
                template_folder='templates/admin')


def get_total_revenue():
    revenue_total_this_month = db.session.query(func.sum(Transaction.total).label('total_revenue')).filter(
        Transaction.is_deleted.is_(False),
        Transaction.status == ORDER_TYPE.COMPLETED,
        extract('month', Transaction.created_at) == datetime.today().month
    ).first()
    revenue_total_last_month = db.session.query(func.sum(Transaction.total).label('total_revenue')).filter(
        Transaction.is_deleted.is_(False),
        Transaction.status == ORDER_TYPE.COMPLETED,
        extract('month', Transaction.created_at) == datetime.today().month - 1 if datetime.today().month > 1 else 12
    ).first()
    total_this_month = revenue_total_this_month.total_revenue if revenue_total_this_month else 1
    total_last_month = 0
    if revenue_total_last_month.total_revenue:
        total_last_month = revenue_total_last_month.total_revenue
    param = {
        'this_month': total_this_month,
        'last_month': total_last_month,
        'compare': (total_this_month - total_last_month) * 100 / total_last_month if total_last_month != 0 else 0
    }
    return param


def get_new_user():
    new_user_this_month = db.session.query(User).filter(
        User.is_deleted.is_(False),
        extract('month', User.created_at) == datetime.today().month
    ).count()
    new_user_last_month = db.session.query(User).filter(
        User.is_deleted.is_(False),
        extract('month', User.created_at) == datetime.today().month - 1 if datetime.today().month > 1 else 12
    ).count()
    total_this_month = new_user_this_month if new_user_this_month else 0
    total_last_month = new_user_last_month if new_user_last_month else 0
    param = {
        'this_month': total_this_month,
        'last_month': total_last_month,
        'compare': (
                           total_this_month - total_last_month) * 100 / total_last_month if total_last_month != 0 and total_this_month != 0 else 0
    }
    return param


def get_total_order_delivery():
    total_delivery_this_month = db.session.query(Transaction).filter(
        Transaction.is_deleted.is_(False),
        Transaction.status == ORDER_TYPE.DELIVERED,
        extract('month', Transaction.created_at) == datetime.today().month
    ).count()
    total_delivery_last_month = db.session.query(Transaction).filter(
        Transaction.is_deleted.is_(False),
        Transaction.status == ORDER_TYPE.DELIVERED,
        extract('month', Transaction.created_at) == datetime.today().month - 1 if datetime.today().month > 1 else 12
    ).count()
    total_this_month = total_delivery_this_month if total_delivery_this_month else 0
    total_last_month = total_delivery_last_month if total_delivery_last_month else 0
    param = {
        'this_month': total_this_month,
        'last_month': total_last_month,
        'compare': (
                           total_this_month - total_last_month) * 100 / total_last_month if total_last_month != 0 and total_this_month != 0 else 0
    }
    return param

def get_out_of_stock_product(stock_limit):
    out_of_stock_product = db.session.query(Stockinproduct).filter(
        Stockinproduct.is_deleted.is_(False),
        Stockinproduct.quantity < stock_limit
    ).count()
    return out_of_stock_product if out_of_stock_product else 0

@mod.route('/dashboard')
@admin_required
def admin():
    revenue_total_dashboard = get_total_revenue()
    new_user_total_dashboard = get_new_user()
    new_order_delivery_dashboard = get_total_order_delivery()
    out_of_stock_product = get_out_of_stock_product(30)
    return render_template('index.html', current_user={}, revenue_total=revenue_total_dashboard,
                           new_order_delivery=new_order_delivery_dashboard,
                           out_of_stock_product=out_of_stock_product,
                           new_user_total=new_user_total_dashboard)
