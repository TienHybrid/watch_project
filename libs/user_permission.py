from flask import session, redirect, url_for
from libs.constant import UserTypeEnum
from functools import wraps


def get_admin_type_in_session():
    admin = session.get('admin', None)
    if not admin:
        return UserTypeEnum.NOT_LOGIN
    admin_type = session.get('admin_type', UserTypeEnum.NOT_LOGIN)
    try:
        return admin_type
    except ValueError:
        UserTypeEnum.NOT_LOGIN


def admin_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        admin_type = get_admin_type_in_session()
        if admin_type != UserTypeEnum.ADMIN_LOGIN:
            return redirect(url_for('authentication.login'))
        return f(*args, **kwargs)

    return decorated


def user_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        admin_type = get_admin_type_in_session()
        if admin_type != UserTypeEnum.USER_LOGIN:
            return redirect(url_for('client.main'))
        return f(*args, **kwargs)

    return decorated
