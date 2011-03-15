
require 'rubygems'
require 'redis'

r = Redis.new
f = File.open("dictionery.txt")
f.each do |word|
mycounter = 0
    while mycounter <= word.length
      key = word[0..mycounter] 
      r.sadd ":#{key}", "#{word}"
      puts "#{key}"
      mycounter += 1
    end
    puts "-#{word.upcase}-"
end
puts "load data complete."
f.close
