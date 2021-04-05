

class UserTypeEnum(object):
    """user type"""
    __slots__ = ()
    NOT_LOGIN = 'none'
    USER_LOGIN = 'user'
    ADMIN_LOGIN = 'admin'


def none_to_empty_string(value):
    if value is None:
        return ''
    else:
        return str(value)