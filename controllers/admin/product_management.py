from flask import Blueprint, render_template
from flask_login import login_required
mod = Blueprint(name='product_management', import_name="__name__", url_prefix='/admin',
                static_folder='static/admin/assets',
                template_folder='templates/admin')


@mod.route('/product_management')
@login_required
def product_management():
    return render_template('product_management.html', current_user={})


@mod.route('/product_management/<id_product>')
@login_required
def product_detail(id_product):
    return render_template('product_detail.html', current_user={})
