import re
import time

from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.common import keys

chromed = 'c:\chromedriver_win32\chromedriver.exe'
driver = webdriver.Chrome(chromed)
driver.get('https://www.jd.com/')
index_window = driver.current_window_handle
time.sleep(2)
driver.find_element_by_link_text('手机').click()
time.sleep(5)
driver.find_element_by_xpath('//*[@id="key"]').send_keys('iphone', keys.Keys.ENTER)
time.sleep(5)
soup = BeautifulSoup(driver.page_source, 'lxml')
for em in soup.select('.p-name em'):
    phone_type = em.get_text()
for i in soup.select('.p-price i'):
    phone_price = i.get_text()
driver.find_element_by_id('kw').send_keys(keys.Keys.PAGE_DOWN)





