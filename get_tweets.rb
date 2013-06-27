require 'rubygems'
require 'oauth'
require 'net/http'
require 'uri'

@consumer_key = ''
@consumer_secret = ''
@token_key = ''
@token_secret = '' 

require './keys'

puts @token_key

url = 'https://api.twitter.com'
uri = URI.parse(url)

consumer = OAuth::Consumer.new(@consumer_key,@consumer_secret, {
    :site=>url
    })

token = OAuth::Token.new(@token_key,@token_secret)

path = '/1.1/search/tweets.json'

querystring = '?q=7digital'

request = consumer.create_signed_request(:get,path+querystring, token)

http = Net::HTTP.new(uri.host, uri.port) 

response = http.request(request)

puts response.body
