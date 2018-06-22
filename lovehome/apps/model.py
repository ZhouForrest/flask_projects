from datetime import datetime

from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash

db = SQLAlchemy()


class BaseModel(object):
    create_time = db.Column(db.DateTime, default=datetime.now)
    update_time = db.Column(db.DateTime, default=datetime.now, onupdate=datetime.now)

    def add_update(self):
        db.session.add(self)
        db.session.commit()

    def delete(self):
        db.session.delete(self)
        db.session.commit()


class Users(BaseModel, db.Model):
    __tablename__ = 'ihome_user'
    u_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    u_tel = db.Column(db.String(11), unique=True)
    u_pwd = db.Column(db.String(200))
    u_name = db.Column(db.String(20))
    u_avatar = db.Column(db.String(100))
    ID_NAME = db.Column(db.String(20))
    ID_CARD = db.Column(db.String(18))

    houses = db.relationship('House', backref='user')
    orders = db.relationship('Order', backref='user')
    @property
    def password(self):
        return ''

    @password.setter
    def password(self, pwd):
        self.u_pwd = generate_password_hash(pwd)

    def check_pwd(self, pwd):
        return check_password_hash(self.u_pwd, pwd)

    def to_auth_dict(self):
        return {
            'ID_NAME': self.ID_NAME,
            'ID_CARD': self.ID_CARD
        }

    def to_bash_dict(self):
        return {
            'u_id': self.u_id,
            'u_avatar': self.u_avatar if self.u_avatar else '',
            'u_name': self.u_name,
            'u_tel': self.u_tel
        }


ihome_house_facility = db.Table(
    "ihome_house_facility",
    db.Column("house_id", db.Integer, db.ForeignKey("ihome_house.id"), primary_key=True),  # 房屋编号
    db.Column("facility_id", db.Integer, db.ForeignKey("ihome_facility.id"), primary_key=True)  # 设施编号
)


class House(BaseModel, db.Model):
    """房屋信息"""

    __tablename__ = "ihome_house"

    id = db.Column(db.Integer, primary_key=True)  # 房屋编号
    # 房屋主人的用户编号
    user_id = db.Column(db.Integer, db.ForeignKey("ihome_user.u_id"), nullable=False)
    # 归属地的区域编号
    area_id = db.Column(db.Integer, db.ForeignKey("ihome_area.id"), nullable=False)
    title = db.Column(db.String(64), nullable=False)  # 标题
    price = db.Column(db.Integer, default=0)  # 单价，单位：分
    address = db.Column(db.String(512), default="")  # 地址
    room_count = db.Column(db.Integer, default=1)  # 房间数目
    acreage = db.Column(db.Integer, default=0)  # 房屋面积
    unit = db.Column(db.String(32), default="")  # 房屋单元， 如几室几厅
    capacity = db.Column(db.Integer, default=1)  # 房屋容纳的人数
    beds = db.Column(db.String(64), default="")  # 房屋床铺的配置
    deposit = db.Column(db.Integer, default=0)  # 房屋押金
    min_days = db.Column(db.Integer, default=1)  # 最少入住天数
    max_days = db.Column(db.Integer, default=0)  # 最多入住天数，0表示不限制
    order_count = db.Column(db.Integer, default=0)  # 预订完成的该房屋的订单数
    index_image_url = db.Column(db.String(256), default="")  # 房屋主图片的路径

    # 房屋的设施
    facilities = db.relationship("Facility", secondary=ihome_house_facility)
    images = db.relationship("HouseImage")  # 房屋的图片
    orders = db.relationship('Order', backref='house')

    def to_dict(self):
        return {
            'id': self.id,
            'title': self.title,
            'image': self.index_image_url if self.index_image_url else '',
            'area': self.area.name,
            'price': self.price,
            'create_time': self.create_time.strftime('%Y-%m-%d %H:%M:%S'),
            # 'avatar':current_app.config['QINIU_URL']+self.user.avatar if self.user.avatar else '',
            'room': self.room_count,
            'order_count': self.order_count,
            'address': self.address
        }

    def to_full_dict(self):
        return {
            'id': self.id,
            'user_avatar': self.user.u_avatar if self.user.u_avatar else '',
            'user_name': self.user.u_name,
            'title': self.title,
            'price': self.price,
            'address': self.area.name+self.address,
            'room_count': self.room_count,
            'acreage': self.acreage,
            'unit': self.unit,
            'capacity': self.capacity,
            'beds': self.beds,
            'deposit': self.deposit,
            'min_days': self.min_days,
            'max_days': self.max_days,
            'order_count': self.order_count,
            'images': [img.url for img in self.images],
            'facilities': [facility.to_dict() for facility in self.facilities],
        }


class HouseImage(BaseModel, db.Model):
    """房屋图片"""

    __tablename__ = "ihome_house_image"

    id = db.Column(db.Integer, primary_key=True)
    # 房屋编号
    house_id = db.Column(db.Integer, db.ForeignKey("ihome_house.id"), nullable=False)
    url = db.Column(db.String(256), nullable=False)  # 图片的路径


class Facility(BaseModel, db.Model):
    """设施信息, 房间规格等信息"""

    __tablename__ = "ihome_facility"

    id = db.Column(db.Integer, primary_key=True)  # 设施编号
    name = db.Column(db.String(32), nullable=False)  # 设施名字
    css = db.Column(db.String(30), nullable=True)  # 设施展示的图标

    def to_dict(self):
        return {
            'id': self.id,
            'name': self.name,
            'css': self.css
        }

    def to_house_dict(self):
        return {'id': self.id}


class Area(BaseModel, db.Model):
    """城区"""

    __tablename__ = "ihome_area"

    id = db.Column(db.Integer, primary_key=True)  # 区域编号
    name = db.Column(db.String(32), nullable=False)  # 区域名字
    houses = db.relationship("House", backref="area")  # 区域的房屋

    def to_dict(self):
        return {
            'id': self.id,
            'name': self.name
        }


class Order(BaseModel,db.Model):
    __tablename__ = "ihome_order"

    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey("ihome_user.u_id"), nullable=False)
    house_id = db.Column(db.Integer, db.ForeignKey("ihome_house.id"), nullable=False)
    begin_date = db.Column(db.DateTime, nullable=False)  # 入住时间
    end_date = db.Column(db.DateTime, nullable=False)  # 离店时间
    days = db.Column(db.Integer, nullable=False)  # 住多少天
    house_price = db.Column(db.Integer, nullable=False)  # 房间价格
    amount = db.Column(db.Integer, nullable=False)  # 总价格
    status = db.Column(
        db.Enum(
            "WAIT_ACCEPT",  # 待接单,
            "WAIT_PAYMENT",  # 待支付
            "PAID",  # 已支付
            "WAIT_COMMENT",  # 待评价
            "COMPLETE",  # 已完成
            "CANCELED",  # 已取消
            "REJECTED"  # 已拒单
        ),
        default="WAIT_ACCEPT", index=True)
    comment = db.Column(db.Text)  # 评论

    def to_dict(self):
        return {
            'order_id':self.id,
            'house_title':self.house.title,
            'image':self.house.index_image_url if self.house.index_image_url else '',
            'create_date':self.create_time.strftime('%Y-%m-%d'),
            'begin_date':self.begin_date.strftime('%Y-%m-%d'),
            'end_date':self.end_date.strftime('%Y-%m-%d'),
            'amount':self.amount,
            'days':self.days,
            'status':self.status,
            'comment':self.comment
        }