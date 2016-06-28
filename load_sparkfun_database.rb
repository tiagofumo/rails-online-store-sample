require 'json'
require 'open-uri'
require 'pp'

categories = JSON.parse open('https://www.sparkfun.com/categories.json').read
# clear retired

pp categories
