require 'json'
require './filters'

results = File.read('results')
parsed_response_body = JSON.parse(results)
filtered_list = parsed_response_body['statuses']

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

i=0
filtered_list.each do |status|
	i+=1
	status["words"].each do |word|
		total = (moods[word].to_i||0) * (status["retweet_count"].to_i+1) #include original
		status["mood"] = (status["mood"]||0) + total

	end
	
	puts "#{status["mood"]}, #{status["text"]}"
end


