require 'rest_client'

puts "What are you looking for?"
query = gets.chomp

response = RestClient.get "https://www.google.pl/?gws_rd=ssl#newwindow=1&q=" + query

puts "Response code"
puts "-----"
puts response.code
puts "-----"
puts "Response cookies"
puts response.cookies
puts "-----"
puts "Response headers"
puts response.headers
puts "-----"
puts "Response body"
puts response.body
