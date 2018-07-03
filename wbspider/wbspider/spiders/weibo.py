import json

import scrapy

from wbspider.items import WbspiderItem


class WboItem(scrapy.spiders.Spider):
    name = 'weibo'
    start_urls = ['https://m.weibo.cn/api/container/getIndex?containerid=231051_-_followers_-_3261134763_-_1042015%253AtagCategory_050&luicode=10000011&lfid=1076033261134763', ]

    def parse(self, response):
        item = WbspiderItem()
        msg = json.loads(response.text)
        users_msg = []
        for i in range(len(msg['data']['cards'])-1):
            for users in msg['data']['cards'][i]['card_group'][1]['users']:
                users_msg.append(users)
        for j in range(len(msg['data']['cards'][3]['card_group'])):
            users_msg.append(msg['data']['cards'][3]['card_group'][j]['user'])
        _id = []
        screen_name = []
        profile_image_url = []
        profile_url = []
        followers_count = []
        follow_count = []
        cover_image_phone = []
        for user in users_msg:
            _id.append(user['id'])
            screen_name.append(user['screen_name'])
            profile_image_url.append(user['profile_image_url'])
            profile_url.append(user['profile_url'])
            followers_count.append(user['followers_count'])
            follow_count.append(user['follow_count'])
            cover_image_phone.append(user['cover_image_phone'])

        item['_id'] = _id
        item['screen_name'] = screen_name
        item['profile_image_url'] = profile_image_url
        item['profile_url'] = profile_url
        item['followers_count'] = followers_count
        item['follow_count'] = follow_count
        item['cover_image_phone'] = cover_image_phone
        return dict(item)

