from datetime import datetime

from flask_sqlalchemy import SQLAlchemy

from models import Category

db = SQLAlchemy()


def get_category_by_category_id(category_id):
    # get all voucher apply for all user
    voucher_all_user = db.session.query(Category) \
        .filter(
        Category.id == category_id,
        Category.is_deleted.is_(False),
    ).first()
    return voucher_all_user
