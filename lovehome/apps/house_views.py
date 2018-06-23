import os
from datetime import datetime

from flask import Blueprint, render_template, jsonify, request, session

from apps.model import Area, Facility, House, HouseImage, db, Order
from utils import status_code
from utils.basic import UPLOAD_DIR
from utils.function import is_login

house = Blueprint('house', __name__)


@house.route('/myhouse/')
def myhouse():
    return render_template('myhouse.html')


@house.route('/newhouse/', methods=['POST', 'GET', 'PATCH'])
@is_login
def newhouse():
    if request.method == 'GET':
        return render_template('newhouse.html')
    if request.method == 'POST':
        data = request.form.to_dict()
        house = House()
        house.user_id = session['u_id']
        house.title = data.get('title')
        house.price = data.get('price')
        house.area_id = data.get('area_id')
        house.address = data.get('address')
        house.room_count = data.get('room_count')
        house.acreage = data.get('acreage')
        house.unit = data.get('unit')
        house.capacity = data.get('capacity')
        house.beds = data.get('beds')
        house.deposit = data.get('deposit')
        house.min_days = data.get('min_days')
        house.max_days = data.get('max_days')
        facility_id = request.form.getlist('facility')
        facility_list = Facility.query.filter(Facility.id.in_(facility_id)).all()#all()将查询结果转化为list
        house.facilities = facility_list
        try:
            house.add_update()
        except:
            return jsonify(status_code.DATABASE_ERROR)
        data = {
            'code': 200,
            'msg': '请求成功',
            'house_id': house.id
        }
        return jsonify(data)
    if request.method == 'PATCH':
        house_id = request.form.get('house_id')
        house_imgs = request.files.getlist('house_image')
        for img in house_imgs:
            imgs = HouseImage()
            imgs.url = os.path.join(UPLOAD_DIR, img.filename)
            imgs.house_id = house_id
            imgs.add_update()
        house = House.query.filter_by(id=house_id).first()
        index_image_url = os.path.join(UPLOAD_DIR, house_imgs[0].filename)
        house.index_image_url = index_image_url
        try:
            house.add_update()
        except:
            db.session.rollback()
            return jsonify(status_code.DATABASE_ERROR)

        return jsonify({'code': 200, 'house_img': index_image_url})


@house.route('/area_msg/')
def area_msg():
    areas = Area.query.all()
    return jsonify([area.to_dict() for area in areas])


@house.route('/facility_msg/')
def facility_msg():
    facilitys = Facility.query.all()
    return jsonify([facility.to_dict() for facility in facilitys])


@house.route('/house_msg/')
def house_msg():
    houses = House.query.all()
    return jsonify([house.to_dict() for house in houses])


@house.route('/search/')
def search():
    return render_template('search.html')


@house.route('/booking/')
def booking():
    return render_template('booking.html')


@house.route('/house_booking/<int:id>/', methods=['GET', 'POST'])
def house_booking(id):
    if request.method == 'GET':
        house = House.query.filter_by(id=id).first()
        return jsonify(house.to_full_dict())
    if request.method == 'POST':

        start_time = datetime.strptime(request.form.get('startime'), '%Y-%m-%d')
        end_time = datetime.strptime(request.form.get('endtime'), '%Y-%m-%d')
        days = (end_time - start_time).days + 1
        orders = Order()
        orders.house_id = id
        orders.days = days
        orders.user_id = session['u_id']
        orders.begin_date = start_time
        orders.end_date = end_time
        house = House.query.filter_by(id=id).first()
        orders.house_price = house.price
        orders.amount = days*house.price
        try:
            orders.add_update()
        except:
            db.session.rollback()
            return jsonify(status_code.DATABASE_ERROR)
        return jsonify(status_code.ok)


@house.route('/orders/')
def orders():
    return render_template('orders.html')


@house.route('/user_orders/')
@is_login
def user_orders():
    user_id = session['u_id']
    orders = Order.query.filter_by(user_id=user_id).all()
    return jsonify([order.to_dict() for order in orders])


@house.route('/detail/')
def detail():
    return render_template('detail.html')


@house.route('/house_detail/<int:id>/')
def house_detail(id):
    house = House.query.filter_by(id=id).first()
    return jsonify(house.to_full_dict())


@house.route('/lorders/')
def lorders():
    return render_template('lorders.html')


@house.route('/user_lorders/', methods=['GET', 'POST'])
def user_lorders():
    if request.method == 'GET':
        houses = House.query.filter_by(user_id=session['u_id']).all()
        house_ids = [house.id for house in houses]
        orders = Order.query.filter(Order.house_id.in_(house_ids)).all()
        return jsonify(code=status_code.ok, orders=[order.to_dict() for order in orders])
    if request.method == 'POST':
        house_id = request.form.get('house_id')
        order = Order.query.get(house_id)
        if request.form.get('token'):
            order.status = 'PAID'
        else:
            order.comment = request.form.get('comment')
            order.status = 'REJECTED'
        try:
            order.add_update()
        except:
            db.session.rollback()
            return jsonify(status_code.DATABASE_ERROR)
        return jsonify(status_code.ok)







