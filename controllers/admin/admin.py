from flask import Blueprint, render_template
from flask_login import login_required, current_user

mod = Blueprint(name='admin', import_name="__name__", url_prefix='/admin', static_folder='static/admin/assets',
                template_folder='templates/admin')


@mod.route('/')
@login_required
def admin():
    return render_template('index.html', current_user=current_user)
