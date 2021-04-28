

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


class ORDER_TYPE(object):
    """user type"""
    __slots__ = ()
    CART = 0
    PAID = 1
    SHIPPED = 2
    DELIVERED = 3
    FAILED = 4
    RETURNED = 5
    COMPLETE = 6
