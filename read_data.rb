
require 'redis'

loop do 
  r = Redis.new
  puts "\n...Ask The mighty Egghead any prefix and hit Enter..."
  q = gets.chomp 
  puts r.smembers q
end