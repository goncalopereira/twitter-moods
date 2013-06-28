def remove_accounts_named name, list
        list.delete_if do |status|
                 status['user']['name'].include? name
        end
end

def add_word_list_entries list
        list.each do |status|
                words = status["text"].downcase.split()
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

def remove_non_alphanumeric list
	list.each do |status|
		status["words"].map! do |word|
			word.gsub(/[^0-9a-z]/i,'')
		end
	end
end

