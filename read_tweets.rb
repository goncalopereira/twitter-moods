require 'json'
require './filters'

def read_from_json filename
	results = File.read(filename)
	parsed_response_body = JSON.parse(results)
	parsed_response_body['statuses']
end

filtered_list = read_from_json 'results'

remove_accounts_named '7digital', filtered_list

add_word_list_entries filtered_list

remove_short_words filtered_list

#hashtags
remove_words_starting_with '#', filtered_list 
#urls
remove_words_starting_with 'http', filtered_list 
#accounts
remove_words_starting_with '@', filtered_list

remove_chars_from_words '\'s', filtered_list
remove_non_alphanumeric filtered_list

moods = Hash.new

File.open('moods').each do |line|
	fields = line.split()
	moods[fields[0]] = fields[1]
end

#add mood to tweet
filtered_list.each do |status|
	status["words"].each do |word|
		total = (moods[word].to_i||0) * (status["retweet_count"].to_i+1) #include original
		status["mood"] = (status["mood"]||0) + total
	end	
end

filtered_list

filtered_list.sort! { |x,y| y["mood"] <=> x["mood"] } 

filtered_list.each do |status|
	puts "#{status["user"]["name"]}, #{status["mood"]}, #{status["text"]}"
end

