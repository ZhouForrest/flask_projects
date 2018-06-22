import os
import re

from flask import Blueprint, render_template, request, session, jsonify

from apps.model import Users, db
from utils import status_code
from utils.basic import UPLOAD_DIR
from utils.function import is_login

lvh = Blueprint('app', __name__)


@lvh.route('/my/')
@is_login
def my():
    user = Users.query.get(session['u_id']).to_bash_dict()
    return render_template('my.html', user=user)


@lvh.route('/profile/', methods=['GET', 'POST', 'PATCH'])
@is_login
def profile():
    if request.method == 'GET':
        return render_template('profile.html')
    #表单提交
    if request.method == 'POST':
        file = request.files.get('avatar')
        if not re.match(r'image/.*', file.mimetype):
            return jsonify(status_code.IMG_FORMAT_ERROR)
        avatar_url = os.path.join(UPLOAD_DIR, file.filename)
        file.save(avatar_url)
        u_id = session['u_id']
        user = Users.query.get(u_id)
        user.u_avatar = avatar_url
        user.add_update()
        return jsonify(status_code.ok)
    #ajax提交
    if request.method == 'PATCH':
        file = request.files.get('avatar')
        if not re.match(r'image/.*', file.mimetype):
            return jsonify(status_code.IMG_FORMAT_ERROR)
        avatar_url = os.path.join(UPLOAD_DIR, file.filename)
        file.save(avatar_url)
        u_id = session['u_id']
        user = Users.query.get(u_id)
        user.u_avatar = avatar_url
        user.add_update()
        data = status_code.IMG_UPLOAD_SUCCESS
        data['avatar'] = user.u_avatar
        return jsonify(data)


@lvh.route('/proname/', methods=['PATCH'])
@is_login
def proname():
    u_name = request.form.get('name')
    user = Users.query.filter_by(u_name=u_name).first()
    if user:
        return jsonify(status_code.USER_NAME_EXISTS)
    user = Users.query.get(session['u_id'])
    user.u_name = u_name
    try:
        user.add_update()
    except:
        db.session.rollback()
        return jsonify(status_code.DATABASE_ERROR)
    return jsonify(status_code.ok)


@lvh.route('/auth/', methods=['GET', 'POST'])
@is_login
def auth():
    if request.method == 'GET':
        user = Users.query.get(session['u_id']).to_auth_dict()
        return render_template('auth.html', user=user)
    if request.method == 'POST':
        id_name = request.form.get('id_name')
        id_card = request.form.get('id_card')
        user = Users.query.get(session['u_id'])
        user.ID_NAME = id_name
        user.ID_CARD = id_card
        if not all([id_card, id_name]):
            return jsonify(status_code.USER_AUTH_MSG_NOT_NULL)
        if not re.match(r'^[1-9][0-9]{17}', id_card):
            return jsonify(status_code.USER_CARD_ERROR)
        try:
            user.add_update()
        except:
            return jsonify(status_code.DATABASE_ERROR)
        return jsonify(status_code.ok)


@lvh.route('/newhouse/')
def newhouse():
    return render_template('newhouse.html')
