
require 'redis'

r = Redis.new
loop do 
  puts "\n...Ask The mighty Egghead any prefix and hit Enter..."
  puts r.smembers gets.chomp
end