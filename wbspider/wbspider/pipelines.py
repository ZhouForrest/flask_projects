# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://doc.scrapy.org/en/latest/topics/item-pipeline.html
from datetime import datetime

from pymongo import MongoClient
from scrapy.conf import settings

from wbspider.items import WbspiderItem


class WbspiderPipeline(object):

    def __init__(self):
        self.conn = MongoClient(settings['MONGODB_HOST'], settings['MONGODB_PORT'])
        self.db = self.conn[settings['MONGODB_DB']]
        self.collection = self.db[WbspiderItem.collection]

    def process_item(self, item, spider):
        id = 0
        for i in range(len(item['screen_name'])):
            data = {
                '_id': id,
                'screen_name': item['screen_name'][i],
                'profile_image_url': item['profile_image_url'][i],
                'profile_url': item['profile_url'][i],
                'followers_count': item['followers_count'][i],
                'follow_count': item['follow_count'][i],
                'cover_image_phone': item['cover_image_phone'][i]
            }
            id += 1
            self.collection.update({'_id':data['_id']}, {'$set':data}, True)
        return item


class CreateTime(object):

    def process_item(self, item, spider):
        dict(item)['create_time'] = datetime.now().strftime('%Y-%m-%d %H:%m')
        return item
