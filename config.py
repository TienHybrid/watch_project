import os

# Grabs the folder where the script runs.
basedir = os.path.abspath(os.path.dirname(__file__))

# Enable debug mode.
DEBUG = True

# Secret key for session management. You can generate random strings here:
# https://randomkeygen.com/
SECRET_KEY = 'secret-key-goes-here'

# Connect to the database
SQLALCHEMY_DATABASE_URI = "postgresql://postgres:1@localhost:5432/watch"
