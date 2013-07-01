def read_from_json filename
        results = File.read(filename)
        parsed_response_body = JSON.parse(results)
        parsed_response_body['statuses']
end

def read_from_csv filename
        results = []
        File.open(filename).each do |line|
                if line.start_with? '<'
                        results << line
                end
        end

        tweets_json = []

        results.each do |line|

                fields = line.split()


                fake_tweet = Hash.new
                fake_tweet["user"] = Hash.new
                fake_tweet["user"]["name"] = fields[0]

                fake_tweet["text"] = line

                tweets_json << fake_tweet
        end

        tweets_json
end

def read_moods
        moods = Hash.new

        File.open('moods').each do |line|
                fields = line.split()
                moods[fields[0]] = fields[1]
        end
	moods
end

def write_results filename, tweets
        File.open(filename, 'w') do |file|
                tweets.each do |status|
                    file.puts "#{status["user"]["name"]}, #{status["mood"]}, #{status["text"]}"
                end
        end
end
