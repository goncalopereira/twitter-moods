require 'json'
require 'csv'
require './filters'
require './io'

def run_twitter_moods filtered_list, filename

	moods = add_values_to_hash 'moods'
        moods = add_values_to_hash 'emoticons', moods
        slang = add_values_to_hash 'slang', nil, '-'

	remove_accounts_named '7digital', filtered_list

	add_word_list_entries filtered_list, slang
	
	remove_short_words filtered_list
#hashtags
	#remove_words_starting_with '#', filtered_list 
#urls
#	remove_words_starting_with 'http', filtered_list 
#accounts
#	remove_words_starting_with '@', filtered_list
	remove_chars_from_words '\'s', filtered_list

	mood_data = []
	#add mood and position to tweet
	i=0
	filtered_list.each do |status|
		status["mood"] = 0
		status["position"] = i

		status["words"].each do |word|
			total = (moods[word].to_i||0) * (status["retweet_count"].to_i+1) #include original
			status["mood"] = (status["mood"]||0) + total
		end	
				
		mood_data << status["mood"]

		i+=1
	end
	
	filtered_list.each do |status|

		current_position = status["position"]			
		
		if current_position >= 4
			moving_average = (filtered_list[current_position]["mood"]+filtered_list[current_position-1]["mood"]+filtered_list[current_position-2]["mood"]+filtered_list[current_position-3]["mood"]+filtered_list[current_position-4]["mood"])/5

			if moving_average.abs >= 2
				puts current_position
				puts write_line filtered_list[current_position]
			end
		end		
	end	
	
	#write results
	write_results filename+"_unsorted_results", filtered_list	

	filtered_list.sort! { |x,y| y["mood"] <=> x["mood"] } 
	write_results filename+"_sorted_results", filtered_list
end




