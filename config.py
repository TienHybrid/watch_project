import os

# Grabs the folder where the script runs.
basedir = os.path.abspath(os.path.dirname(__file__))

# Enable debug mode.
DEBUG = True

# Secret key for session management. You can generate random strings here:
# https://randomkeygen.com/
SECRET_KEY = 'secret-key-goes-here'

# Connect to the database
SQLALCHEMY_DATABASE_URI = os.environ.get('SQLALCHEMY_DATABASE_URI', "postgresql://postgres:1@localhost:5432/watch")

STAFF_FOLDER = 'staff'
USER_FOLDER = 'User'
CATEGORY_FOLDER = 'Category'
PRODUCT_FOLDER = 'Product'

FILTER_PRICE = [
    {"id": 1, "name": "Duới 1 Triệu", "start": None, "end": 1000000},
    {"id": 2, "name": "Từ 1 Triệu đến 3 triệu", "start": 1000000, "end": 3000000},
    {"id": 3, "name": "Từ 3 Triệu đến 5 Triệu", "start": 3000000, "end": 5000000},
    {"id": 4, "name": "Từ 5 Triệu đến 10 Triệu", "start": 5000000, "end": 10000000},
    {"id": 5, "name": "Trên 10 Triệu", "start": 10000000, "end": None},
]

VOUCHER_TYPE = ['user', 'all_user']