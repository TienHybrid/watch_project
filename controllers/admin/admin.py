from flask import Blueprint, render_template
from libs.user_permission import admin_required


mod = Blueprint(name='admin', import_name="__name__", url_prefix='/admin', static_folder='static/admin/assets',
                template_folder='templates/admin')


@mod.route('/dashboard')
@admin_required
def admin():
    return render_template('index.html', current_user={})
