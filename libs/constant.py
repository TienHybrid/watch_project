

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
    ORDER = 1
    DELIVERED = 2
    COMPLETED = 3
    CANCELED = 4



class SHIPPING_METHOD(object):
    """user type"""
    __slots__ = ()
    COD = 0
    PLANE =1
