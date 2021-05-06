# coding: utf-8
from sqlalchemy import ARRAY, Boolean, Column, DateTime, ForeignKey, Integer, MetaData, SmallInteger, String, Text, INTEGER, VARCHAR
from sqlalchemy.schema import FetchedValue
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.ext.hybrid import hybrid_property


Base = declarative_base()
metadata = Base.metadata



class Transaction(Base):
    __tablename__ = 'Transaction'

    id = Column(Integer, primary_key=True, server_default=FetchedValue())
    user_id = Column(ForeignKey('User.id'), nullable=False)
    user_name = Column(String(60), nullable=False, server_default=FetchedValue())
    email = Column(String(60), nullable=False, server_default=FetchedValue())
    phone_number = Column(String(11), nullable=False, server_default=FetchedValue())
    address = Column(Text, nullable=False, server_default=FetchedValue())
    content = Column(Text, nullable=False, server_default=FetchedValue())
    status = Column(Integer, nullable=False, server_default=FetchedValue())
    shipping_method = Column(SmallInteger, nullable=False, server_default=FetchedValue())
    created_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    updated_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    is_deleted = Column(Boolean, nullable=False, server_default=FetchedValue())
    voucher_id = Column(ForeignKey('voucher.id'))
    discount = Column(Integer, server_default=FetchedValue())
    shipping_fee = Column(Integer, server_default=FetchedValue())
    subtotal = Column(Integer, server_default=FetchedValue())
    total = Column(Integer, server_default=FetchedValue())

    user = relationship('User', primaryjoin='Transaction.user_id == User.id', backref='transactions')
    voucher = relationship('Voucher', primaryjoin='Transaction.voucher_id == Voucher.id', backref='transactions')



class User(Base):
    __tablename__ = 'User'

    id = Column(Integer, primary_key=True, server_default=FetchedValue())
    username = Column(String(60), nullable=False, unique=True)
    fullname = Column(String(60))
    email = Column(String(255), nullable=False, unique=True)
    password = Column(String(255), nullable=False)
    address = Column(String)
    phone_number = Column(String(11))
    avatar_url = Column(String(256))
    created_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    updated_at = Column(DateTime, server_default=FetchedValue())
    is_deleted = Column(Boolean, nullable=False, server_default=FetchedValue())
    place_id = Column(ForeignKey('placemaster.id'))

    place = relationship('Placemaster', primaryjoin='User.place_id == Placemaster.id', backref='users')



class Brand(Base):
    __tablename__ = 'brand'

    id = Column(Integer, primary_key=True, server_default=FetchedValue())
    name = Column(String(60), nullable=False)
    image_url = Column(String)
    created_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    updated_at = Column(DateTime, server_default=FetchedValue())
    is_deleted = Column(Boolean, nullable=False, server_default=FetchedValue())



class Cart(Base):
    __tablename__ = 'cart'

    id = Column(Integer, primary_key=True, server_default=FetchedValue())
    user_id = Column(ForeignKey('User.id'), nullable=False)
    created_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    updated_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    is_deleted = Column(Boolean, nullable=False, server_default=FetchedValue())

    user = relationship('User', primaryjoin='Cart.user_id == User.id', backref='carts')



class Cartproduct(Base):
    __tablename__ = 'cartproduct'

    id = Column(Integer, primary_key=True, server_default=FetchedValue())
    stock_id = Column(ForeignKey('stock.id'), nullable=False)
    cart_id = Column(ForeignKey('cart.id'), nullable=False)
    product_id = Column(ForeignKey('product.id'), nullable=False)
    quantity = Column(Integer, nullable=False, server_default=FetchedValue())
    created_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    updated_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    is_deleted = Column(Boolean, nullable=False, server_default=FetchedValue())

    cart = relationship('Cart', primaryjoin='Cartproduct.cart_id == Cart.id', backref='cartproducts')
    product = relationship('Product', primaryjoin='Cartproduct.product_id == Product.id', backref='cartproducts')
    stock = relationship('Stock', primaryjoin='Cartproduct.stock_id == Stock.id', backref='cartproducts')



class Category(Base):
    __tablename__ = 'category'

    id = Column(Integer, primary_key=True, server_default=FetchedValue())
    name = Column(String(60), nullable=False)
    image_url = Column(String)
    created_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    updated_at = Column(DateTime, server_default=FetchedValue())
    is_deleted = Column(Boolean, nullable=False, server_default=FetchedValue())



class Commentproduct(Base):
    __tablename__ = 'commentproduct'

    id = Column(Integer, primary_key=True, server_default=FetchedValue())
    content = Column(String, nullable=False)
    stock_id = Column(ForeignKey('stock.id'), nullable=False)
    user_id = Column(ForeignKey('User.id'), nullable=False)
    product_id = Column(ForeignKey('product.id'), nullable=False)
    created_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    updated_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    is_deleted = Column(Boolean, nullable=False, server_default=FetchedValue())

    product = relationship('Product', primaryjoin='Commentproduct.product_id == Product.id', backref='commentproducts')
    stock = relationship('Stock', primaryjoin='Commentproduct.stock_id == Stock.id', backref='commentproducts')
    user = relationship('User', primaryjoin='Commentproduct.user_id == User.id', backref='commentproducts')



class Guaranteeinfo(Base):
    __tablename__ = 'guaranteeinfo'

    id = Column(Integer, primary_key=True, server_default=FetchedValue())
    transactionproduct_id = Column(ForeignKey('transactionproduct.id'), nullable=False)
    content = Column(String, nullable=False)
    created_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    updated_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    is_deleted = Column(Boolean, nullable=False, server_default=FetchedValue())

    transactionproduct = relationship('Transactionproduct', primaryjoin='Guaranteeinfo.transactionproduct_id == Transactionproduct.id', backref='guaranteeinfos')



class Place(Base):
    __tablename__ = 'place'

    id = Column(Integer, primary_key=True, server_default=FetchedValue())
    name = Column(String(60), nullable=False)
    short_name = Column(String(60), nullable=False)
    created_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    updated_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    is_deleted = Column(Boolean, nullable=False, server_default=FetchedValue())



class Placemaster(Base):
    __tablename__ = 'placemaster'

    id = Column(Integer, primary_key=True, server_default=FetchedValue())
    name = Column(String(60), nullable=False)
    short_name = Column(String(60), nullable=False)
    created_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    updated_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    is_deleted = Column(Boolean, nullable=False, server_default=FetchedValue())



class Product(Base):
    __tablename__ = 'product'

    id = Column(Integer, primary_key=True, server_default=FetchedValue())
    name = Column(String(60), nullable=False)
    price = Column(Integer, nullable=False, server_default=FetchedValue())
    category_id = Column(ForeignKey('category.id'))
    image_url = Column(ARRAY(VARCHAR()), server_default=FetchedValue())
    slug = Column(String, unique=True)
    description = Column(String)
    created_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    updated_at = Column(DateTime, server_default=FetchedValue())
    is_deleted = Column(Boolean, nullable=False, server_default=FetchedValue())
    brand_id = Column(ForeignKey('brand.id'), server_default=FetchedValue())
    old_price = Column(Integer, server_default=FetchedValue())

    brand = relationship('Brand', primaryjoin='Product.brand_id == Brand.id', backref='products')
    category = relationship('Category', primaryjoin='Product.category_id == Category.id', backref='products')

    @hybrid_property
    def down_price(self):
        return (self.price - self.old_price) * 100 / self.old_price


class Staff(Base):
    __tablename__ = 'staff'

    id = Column(Integer, primary_key=True, server_default=FetchedValue())
    username = Column(String(60), nullable=False, unique=True)
    fullname = Column(String(60))
    email = Column(String(255), nullable=False, unique=True)
    password = Column(String(255), nullable=False)
    address = Column(String)
    phone_number = Column(String(11))
    avatar_url = Column(String(256))
    created_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    updated_at = Column(DateTime, server_default=FetchedValue())
    is_deleted = Column(Boolean, nullable=False, server_default=FetchedValue())



class Stock(Base):
    __tablename__ = 'stock'

    id = Column(Integer, primary_key=True, server_default=FetchedValue())
    name = Column(String(60), nullable=False)
    place_id = Column(ForeignKey('place.id'))
    created_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    updated_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    is_deleted = Column(Boolean, nullable=False, server_default=FetchedValue())

    place = relationship('Place', primaryjoin='Stock.place_id == Place.id', backref='stocks')



class Stockinproduct(Base):
    __tablename__ = 'stockinproduct'

    id = Column(Integer, primary_key=True, server_default=FetchedValue())
    stock_id = Column(ForeignKey('stock.id'))
    product_id = Column(ForeignKey('product.id'))
    quantity = Column(Integer, nullable=False)
    created_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    updated_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    is_deleted = Column(Boolean, nullable=False, server_default=FetchedValue())

    product = relationship('Product', primaryjoin='Stockinproduct.product_id == Product.id', backref='stockinproducts')
    stock = relationship('Stock', primaryjoin='Stockinproduct.stock_id == Stock.id', backref='stockinproducts')



class Transactionproduct(Base):
    __tablename__ = 'transactionproduct'

    id = Column(Integer, primary_key=True, server_default=FetchedValue())
    stock_id = Column(ForeignKey('stock.id'), nullable=False)
    transaction_id = Column(ForeignKey('Transaction.id'), nullable=False)
    product_id = Column(ForeignKey('product.id'), nullable=False)
    quantity = Column(Integer, nullable=False, server_default=FetchedValue())
    created_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    updated_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    is_deleted = Column(Boolean, nullable=False, server_default=FetchedValue())
    guarantee_time = Column(DateTime)

    product = relationship('Product', primaryjoin='Transactionproduct.product_id == Product.id', backref='transactionproducts')
    stock = relationship('Stock', primaryjoin='Transactionproduct.stock_id == Stock.id', backref='transactionproducts')
    transaction = relationship('Transaction', primaryjoin='Transactionproduct.transaction_id == Transaction.id', backref='transactionproducts')



class Voucher(Base):
    __tablename__ = 'voucher'

    id = Column(Integer, primary_key=True, server_default=FetchedValue())
    name = Column(String(60), nullable=False)
    type = Column(String(60), nullable=False)
    begin_date = Column(DateTime, nullable=False, server_default=FetchedValue())
    end_date = Column(DateTime, nullable=False, server_default=FetchedValue())
    created_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    updated_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    is_deleted = Column(Boolean, nullable=False, server_default=FetchedValue())
    discount = Column(Integer, server_default=FetchedValue())
    active = Column(Boolean, server_default=FetchedValue())
    code = Column(String, server_default=FetchedValue())



class Voucherinuser(Base):
    __tablename__ = 'voucherinuser'

    id = Column(Integer, primary_key=True, server_default=FetchedValue())
    user_id = Column(ForeignKey('User.id'))
    voucher_id = Column(ForeignKey('voucher.id'))
    created_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    updated_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    is_deleted = Column(Boolean, nullable=False, server_default=FetchedValue())

    user = relationship('User', primaryjoin='Voucherinuser.user_id == User.id', backref='voucherinusers')
    voucher = relationship('Voucher', primaryjoin='Voucherinuser.voucher_id == Voucher.id', backref='voucherinusers')
