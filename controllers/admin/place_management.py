from flask import Blueprint, render_template, request
from libs.user_permission import admin_required
from flask_sqlalchemy import SQLAlchemy
from models import Place
from common.constant import ROWS_PER_PAGE
import json
from sqlalchemy import or_

mod = Blueprint(name='place_management', import_name="__name__", url_prefix='/admin',
                static_folder='static/admin/assets',
                template_folder='templates/admin')

db = SQLAlchemy()


def handle_create_or_update_place(form, id_place):
    """
    Get detail
    :param form:
    :param id_place:
    :param file:
    :return:
    """
    name = form['name']
    short_name = form['short_name']
    if id_place == 'add':
        place = Place(
            name=name,
            short_name=short_name
        )
        db.session.add(place)
    else:
        place = db.session.query(Place).filter_by(id=int(id_place)).first()
        place.name = name
        place.short_name = short_name
        db.session.merge(place)
    db.session.commit()
    return place


@mod.route('/place_management')
@admin_required
def place_management():
    page = request.args.get('page', 1, type=int)
    search = request.args.get('search', None)
    list_place = db.session.query(Place).filter(Place.is_deleted.is_(False))
    if search:
        list_place = list_place.filter(or_(Place.name.like('%' + search + '%')))

    list_place = list_place.paginate(page=page, per_page=ROWS_PER_PAGE)
    return render_template('place_management.html', places=list_place)


@mod.route('/place_management/<id_place>', methods=['GET', 'POST'])
@admin_required
def place_detail(id_place):
    if request.method == 'POST':
        data = request.form
        place = handle_create_or_update_place(form=data, id_place=id_place)
        return json.dumps({'message': 'Successfully', 'id_place': place.id})
    else:
        if id_place == 'add':
            return render_template('place_detail.html', title='Thêm Mới Thành Phố', id_place='add',
                                   place={})
        else:
            current_place = db.session.query(Place).filter(Place.id == int(id_place),
                                                                 Place.is_deleted.is_(False)).first()
            return render_template('place_detail.html', title='Chỉnh Sửa Thành Phố', place=current_place,
                                   id_place=id_place)


@mod.route('/place_management/delete/<id_place>', methods=['POST'])
@admin_required
def delete_place_detail(id_place):
    current_place = db.session.query(Place).filter(Place.id == int(id_place),
                                                       Place.is_deleted.is_(False)).first()
    if current_place:
        current_place.is_deleted = True
        db.session.commit()
    return 'Delete question successfully'