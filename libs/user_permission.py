from flask import session, redirect, url_for, g
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
        return UserTypeEnum.NOT_LOGIN


def get_user_type_in_session():
    user = session.get('user', None)
    if not user:
        return UserTypeEnum.NOT_LOGIN
    user_type = session.get('user_type', UserTypeEnum.NOT_LOGIN)
    try:
        return user_type
    except ValueError:
        return UserTypeEnum.NOT_LOGIN

def admin_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        admin_type = get_admin_type_in_session()
        if admin_type != UserTypeEnum.ADMIN_LOGIN:
            return redirect(url_for('authentication_admin.login'))
        return f(*args, **kwargs)

    return decorated


def user_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        user_type = get_user_type_in_session()
        if user_type != UserTypeEnum.USER_LOGIN:
            return redirect(url_for('authentication_client.login'))
        return f(*args, **kwargs)

    return decorated
