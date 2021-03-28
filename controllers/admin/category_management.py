from flask import Blueprint, render_template
from flask_login import login_required
mod = Blueprint(name='category_management', import_name="__name__", url_prefix='/admin',
                static_folder='static/admin/assets',
                template_folder='templates/admin')


@mod.route('/category_management')
@login_required
def category_management():
    return render_template('category_management.html', current_user={})


@mod.route('/category_management/<id_category>')
@login_required
def category_detail(id_category):
    return render_template('category_detail.html', current_user={})
