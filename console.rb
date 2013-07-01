#!/usr/bin/env ruby
require './read_tweets'

filtered_list = []

if ARGV[0] == 'json'
	filtered_list = read_from_json ARGV[1]
end

if ARGV[0] == 'csv'
	filtered_list = read_from_csv ARGV[1]
end

run_twitter_moods filtered_list, ARGV[1]

