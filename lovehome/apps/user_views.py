import re

from flask import Blueprint, request, render_template, session, jsonify, redirect, url_for

from apps.model import Users, db
from utils import status_code
from utils.function import is_login

user = Blueprint('user', __name__)


@user.route('/register/', methods=['GET', 'POST'])
def register():
    if request.method == 'GET':
        return render_template('register.html')
    if request.method == 'POST':
        password = request.form.get('password')
        password2 = request.form.get('password2')
        mobile = request.form.get('mobile')
        if not all([password, password2, mobile]):
            return jsonify(status_code.USER_REGISTER_DATA_NOT_NULL)
        if password != password2:
            return jsonify(status_code.USER_REGISTER_PASSWORD_IS_NOT_VALID)
        if Users.query.filter_by(u_tel=mobile).all():
            return jsonify(status_code.USER_REGISTER_MOBILE_EXISTS)
        if not re.match(r'^1[345789]\d{9}', mobile):
            return jsonify(status_code.USER_REGISTER_MOBILE_ERROR)
        user = Users()
        user.u_tel = mobile
        user.password = password
        user.add_update()
        return jsonify(status_code.ok)


@user.route('/login/', methods=['GET', 'POST'])
def login():
    if request.method == 'GET':
        return render_template('login.html')
    if request.method == 'POST':
        mobile = request.form.get('mobile')
        password = request.form.get('password')
        user = Users.query.filter_by(u_tel=mobile).first()
        if not user:
            return jsonify(status_code.USER_LOGIN_NOT_EXISTS)
        if not user.check_pwd(password):
            return jsonify(status_code.USER_LOGIN_MSG_ERROR)
        session['u_id'] = user.u_id
        return jsonify(status_code.ok)


@user.route('/logout/')
def logout():
    session.clear()
    return redirect(url_for('user.login'))


@user.route('/status/', methods=['GET'])
@is_login
def status():
    user = Users.query.get(session['u_id'])
    return jsonify(user=user.to_auth_dict())








