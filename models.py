# coding: utf-8
from sqlalchemy import ARRAY, Boolean, Column, DateTime, ForeignKey, Integer, MetaData, String, VARCHAR,INTEGER
from sqlalchemy.schema import FetchedValue
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base


Base = declarative_base()
metadata = Base.metadata



class User(Base):
    __tablename__ = 'User'

    id = Column(Integer, primary_key=True, server_default=FetchedValue())
    username = Column(String(60), nullable=False, unique=True)
    email = Column(String(255), nullable=False, unique=True)
    password = Column(String(255), nullable=False)
    address = Column(String)
    phone_number = Column(String(11))
    avatar_url = Column(String(256))
    created_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    updated_at = Column(DateTime, server_default=FetchedValue())
    is_deleted = Column(Boolean, nullable=False, server_default=FetchedValue())
    fullname = Column(String(60))
    voucher = Column(ARRAY(INTEGER()), server_default=FetchedValue())



class Category(Base):
    __tablename__ = 'category'

    id = Column(Integer, primary_key=True, server_default=FetchedValue())
    name = Column(String(60), nullable=False)
    image_url = Column(String)
    created_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    updated_at = Column(DateTime, server_default=FetchedValue())
    is_deleted = Column(Boolean, nullable=False, server_default=FetchedValue())



class Place(Base):
    __tablename__ = 'place'

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
    quantity = Column(Integer, nullable=False, server_default=FetchedValue())
    category_id = Column(ForeignKey('category.id'))
    image_url = Column(ARRAY(VARCHAR()), server_default=FetchedValue())
    slug = Column(String, unique=True)
    description = Column(String)
    created_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    updated_at = Column(DateTime, server_default=FetchedValue())
    is_deleted = Column(Boolean, nullable=False, server_default=FetchedValue())

    category = relationship('Category', primaryjoin='Product.category_id == Category.id', backref='products')



class Staff(Base):
    __tablename__ = 'staff'

    id = Column(Integer, primary_key=True, server_default=FetchedValue())
    username = Column(String(60), nullable=False, unique=True)
    email = Column(String(255), nullable=False, unique=True)
    password = Column(String(255), nullable=False)
    address = Column(String, server_default=FetchedValue())
    phone_number = Column(String(11))
    avatar_url = Column(String(256))
    created_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    updated_at = Column(DateTime, server_default=FetchedValue())
    is_deleted = Column(Boolean, nullable=False, server_default=FetchedValue())
    fullname = Column(String(60))



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
