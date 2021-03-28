# coding: utf-8
from flask_login import UserMixin
from sqlalchemy import ARRAY, Boolean, Column, DateTime, ForeignKey, Integer, String, VARCHAR
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
from sqlalchemy.orm import scoped_session, sessionmaker
from sqlalchemy.schema import FetchedValue

Base = declarative_base()
engine = create_engine('postgresql://postgres:1@localhost:5432/watch')
db_session = scoped_session(sessionmaker(autocommit=False,
                                         autoflush=False,
                                         bind=engine))
metadata = Base.metadata
Base.query = db_session.query_property()


class User(UserMixin, Base):
    __tablename__ = 'User'

    id = Column(Integer, primary_key=True, server_default=FetchedValue())
    username = Column(String(60), nullable=False)
    email = Column(String(255), nullable=False)
    password = Column(String(255), nullable=False)
    address = Column(String)
    phone_number = Column(String(11))
    avatar_url = Column(String(256))
    created_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    updated_at = Column(DateTime, server_default=FetchedValue())
    is_deleted = Column(Boolean, nullable=False, server_default=FetchedValue())


class Category(Base):
    __tablename__ = 'category'

    id = Column(Integer, primary_key=True, server_default=FetchedValue())
    name = Column(String(60), nullable=False)
    image_url = Column(String)
    created_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    updated_at = Column(DateTime, server_default=FetchedValue())
    is_deleted = Column(Boolean, nullable=False, server_default=FetchedValue())


class Product(Base):
    __tablename__ = 'product'

    id = Column(Integer, primary_key=True, server_default=FetchedValue())
    name = Column(String(60), nullable=False)
    price = Column(Integer, nullable=False, server_default=FetchedValue())
    quantity = Column(Integer, nullable=False, server_default=FetchedValue())
    category_id = Column(ForeignKey('category.id'))
    image_url = Column(ARRAY(VARCHAR()), server_default=FetchedValue())
    slug = Column(String)
    description = Column(String)
    created_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    updated_at = Column(DateTime, server_default=FetchedValue())
    is_deleted = Column(Boolean, nullable=False, server_default=FetchedValue())

    category = relationship('Category', primaryjoin='Product.category_id == Category.id', backref='products')


class Staff(UserMixin, Base):
    __tablename__ = 'staff'

    id = Column(Integer, primary_key=True, server_default=FetchedValue())
    username = Column(String(60), nullable=False)
    email = Column(String(255), nullable=False)
    password = Column(String(255), nullable=False)
    address = Column(String)
    phone_number = Column(String(11))
    avatar_url = Column(String(256))
    created_at = Column(DateTime, nullable=False, server_default=FetchedValue())
    updated_at = Column(DateTime, server_default=FetchedValue())
    is_deleted = Column(Boolean, nullable=False, server_default=FetchedValue())


Base.metadata.create_all(bind=engine)
