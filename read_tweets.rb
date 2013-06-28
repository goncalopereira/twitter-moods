require 'json'

results = File.read('results')
parsed_response_body = JSON.parse(results)
filtered_list = parsed_response_body['statuses']

def remove_accounts_named name, list
	list.delete_if do |status|
		 status['user']['name'].include? name
	end
	list	
end

def add_word_list_entries list
	list.each do |status|
		words = status["text"].split( )
		status["words"] = words
	end
end

def remove_words_starting_with chars, list
	list.each do |status|
		status["words"].delete_if do |word|
			word.start_with?(chars)
		end
	end
end

def remove_short_words list
	list.each do |status|
		status["words"].delete_if do |word|
			word.length <= 2
		end
	end
end

def remove_chars_from_words chars, list
	list.each do |status|
		status["words"].map! do |word|
			word.delete(chars)
		end
	end
end

remove_accounts_named '7digital', filtered_list

add_word_list_entries filtered_list

remove_short_words filtered_list

#hashtags
remove_words_starting_with '#', filtered_list 
#urls
remove_words_starting_with 'http', filtered_list 
#accounts
remove_words_starting_with '@', filtered_list

remove_chars_from_words ',', filtered_list
remove_chars_from_words '-', filtered_list
remove_chars_from_words ':', filtered_list
remove_chars_from_words '"', filtered_list
remove_chars_from_words '\'s', filtered_list

i=0
filtered_list.each do |status|
	i+=1
	puts "#{i}, #{status["created_at"]}, #{status["lang"]}, #{status["user"]["name"]}, #{status["retweet_count"]}"
	status["words"].each do |word|
		puts word
	end
end


