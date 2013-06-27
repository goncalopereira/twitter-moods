require 'rubygems'
require 'oauth'

consumer_key = ''
consumer_secret = ''
token_key = ''
token_secret = '' 

require './keys'

consumer = OAuth::Consumer.new(consumer_key,consumer_secret, {
    :site=>"https://api.twitter.com"
    })

token = OAuth::Token.new(token_key,token_secret)

path = '/1.1/search/tweets.json'

querystring = '?q=7digital'

request = consumer.create_signed_request(:get,path+querystring, token)

puts request.methods


