# ----------------------------------------------------------------------------#
# Imports
# ----------------------------------------------------------------------------#

import logging
from logging import Formatter, FileHandler

from flask import Flask
from flask_sqlalchemy import SQLAlchemy

from controllers.admin import admin, authentication, product_management, user_management, category_management, \
    staff_management
from controllers.client import main, product, cart
from libs.constant import none_to_empty_string


# ----------------------------------------------------------------------------#
# App Config.
# ----------------------------------------------------------------------------#


def create_app():
    my_app = Flask(__name__)
    my_app.config.from_object('config')
    my_app.register_blueprint(main.mod)
    my_app.register_blueprint(cart.mod)
    my_app.register_blueprint(product.mod)
    my_app.register_blueprint(admin.mod)
    my_app.register_blueprint(product_management.mod)
    my_app.register_blueprint(staff_management.mod)
    my_app.register_blueprint(category_management.mod)
    my_app.register_blueprint(user_management.mod)
    my_app.register_blueprint(authentication.mod)
    # init database
    db = SQLAlchemy(my_app)
    db.init_app(my_app)
    return my_app


app = create_app()
app.jinja_env.globals.update(none_to_empty_string=none_to_empty_string)


@app.context_processor
def inject_stage_and_region():
    return dict(stage="alpha", region="NA")


# @app.route('/')
# def main():
#     category = db.session.query(Category).all()
#     return render_template('client.html', category=category)
# Automatically tear down SQLAlchemy.
'''
@app.teardown_request
def shutdown_session(exception=None):
    db.remove()
'''

# Login required decorator.
'''
def login_required(test):
    @wraps(test)
    def wrap(*args, **kwargs):
        if 'logged_in' in session:
            return test(*args, **kwargs)
        else:
            flash('You need to login first.')
            return redirect(url_for('login'))
    return wrap
'''
# ----------------------------------------------------------------------------#
# Controllers.
# ----------------------------------------------------------------------------#


if not app.debug:
    file_handler = FileHandler('error.log')
    file_handler.setFormatter(
        Formatter('%(asctime)s %(levelname)s: %(message)s [in %(pathname)s:%(lineno)d]')
    )
    app.logger.setLevel(logging.INFO)
    file_handler.setLevel(logging.INFO)
    app.logger.addHandler(file_handler)
    app.logger.info('errors')

# ----------------------------------------------------------------------------#
# Launch.
# ----------------------------------------------------------------------------#

# Default port:
if __name__ == '__main__':
    app.run()

# Or specify port manually:
'''
if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port)
'''
