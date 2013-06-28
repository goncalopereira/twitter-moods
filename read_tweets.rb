require 'json'

results = File.read('results')
parsed_response_body = JSON.parse(results)
filtered_list = parsed_response_body['statuses']

def remove_accounts_named name, list
	resulting_list = Array.new
	
	list.each do |status|
		if !status['user']['name'].include? name
			resulting_list  << status
		end
	end
	
	resulting_list
end

def add_word_list_entries list
	list.each do |status|
		words = status["text"].split( )
		status["words"] = words
	end
	
	list
end

filtered_list = remove_accounts_named '7digital', filtered_list
filtered_list = add_word_list_entries filtered_list

i=0
filtered_list.each do |status|
	i+=1
	puts "#{i}, #{status["created_at"]}, #{status["lang"]}, #{status["user"]["name"]}, #{status["retweet_count"]}, #{status["text"]}"
	status["words"].each do |word|
		puts word
	end
end


