import scrapy
from scrapy import Selector

from dbspider.items import DbspiderItem


class DouBan(scrapy.spiders.Spider):
    name = 'douban'
    start_urls = []
    for u in range(10):
        url = 'https://movie.douban.com/top250?start=%d' % (u*25)
        start_urls.append(url)

    def parse(self, response):
        res = Selector(response)
        item = DbspiderItem()
        item['name'] = res.xpath('//*[@id="content"]/div/div[1]/ol/li/div/div[2]/div[1]/a/span[1]/text()').extract()
        msg = res.xpath('//*[@id="content"]/div/div[1]/ol/li/div/div[2]/div[2]/p[1]/text()').extract()
        item['year'] = res.xpath('//*[@id="content"]/div/div[1]/ol/li/div/div[2]/div[2]/p[1]/text()[2]').re(r'\d+')
        item['director'] = msg[0].strip().replace('\xa0', '')
        item['avatar'] = res.xpath('//*[@id="content"]/div/div[1]/ol/li/div/div[1]/a/img/@src')

        return item



