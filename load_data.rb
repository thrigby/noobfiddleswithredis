
require 'rubygems'
require 'redis'

r = Redis.new
r.flushall
f = File.open("dictionery.txt") do |f|
f.each do |word|
    word = word.chomp
    word.length.times { |i| r.sadd word[0..i] , word }
  end
end