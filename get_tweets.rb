require 'rubygems'
require 'oauth'
require 'net/http'
require 'uri'
require 'json'

@consumer_key = ''
@consumer_secret = ''
@token_key = ''
@token_secret = '' 

require './keys'

url = 'http://api.twitter.com'
uri = URI.parse(url)

consumer = OAuth::Consumer.new(@consumer_key,@consumer_secret, {
    :site=>url
    })

token = OAuth::Token.new(@token_key,@token_secret)

path = '/1.1/search/tweets.json'

searchTerms="7digital"

querystring = "?q="+URI.encode(searchTerms)+"&count=100&lang=en"

puts querystring

request = consumer.create_signed_request(:get,path+querystring, token)

http = Net::HTTP.new(uri.host, uri.port) 

response = http.request(request)

File.open('results', 'w') { |file| file.write(response.body) }

