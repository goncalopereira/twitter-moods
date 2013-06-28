require 'json'

results = File.read('results')

parsed_response_body = JSON.parse(results)

i=0
parsed_response_body['statuses'].each do |status|
       i+=1
       puts "#{i}, #{status["created_at"]}, #{status["lang"]}, #{status["user"]["name"]}, #{status["retweet_count"]}, #{status["text"]}"
end


