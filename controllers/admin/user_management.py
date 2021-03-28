from flask import Blueprint, render_template
from flask_login import login_required
mod = Blueprint(name='user_management', import_name="__name__", url_prefix='/admin',
                static_folder='static/admin/assets',
                template_folder='templates/admin')


@mod.route('/user_management')
@login_required
def user_management():
    return render_template('user_management.html', current_user={})


@mod.route('/user_management/<id_user>')
@login_required
def user_detail(id_user):
    return render_template('user_detail.html', current_user={})
