from datetime import datetime

from flask_sqlalchemy import SQLAlchemy

from models import Voucher, User

db = SQLAlchemy()


def get_all_voucher(type=None, limit=None):
    voucher_all_user = db.session.query(Voucher) \
        .filter(
        Voucher.active.is_(True),
        Voucher.is_deleted.is_(False),
        Voucher.begin_date <= datetime.now(),
        Voucher.end_date >= datetime.now(),
    )
    if type:
        voucher_all_user = voucher_all_user.filter(
                Voucher.type == type
        )
    if limit:
        voucher_all_user = voucher_all_user.limit(limit)
    voucher_all_user = voucher_all_user.all()
    return voucher_all_user


def get_voucher_by_voucher_id(voucher_ids):
    voucher_current_user = db.session.query(Voucher) \
        .filter(
        Voucher.id.in_(voucher_ids),
        Voucher.active.is_(True),
        Voucher.is_deleted.is_(False),
        Voucher.begin_date <= datetime.now(),
        Voucher.end_date >= datetime.now(),
        Voucher.type == 'user'
    ).all()

    return [q.id for q in voucher_current_user]
