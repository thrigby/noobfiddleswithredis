# compl1.rb - Redis autocomplete example
# download female-names.txt from http://antirez.com/misc/female-names.txt

require 'rubygems'
require 'redis'

loop do

  r = Redis.new

  # Create the completion sorted set
  if !r.exists(:compl)
    puts "Loading entries in the Redis DB\n"
    File.new('dictionery.txt').each_line{|n|
      n.strip!
      (1..(n.length)).each{|l|
        prefix = n[0...l]
        r.zadd(:compl,0,prefix)
      }
      r.zadd(:compl,0,n+"*")
    }
  else
    puts "NOT loading entries, \nthere is already a 'compl' key\n PLEASE ENTER YOUR QUERY: >"
  end

  # Complete the string "mar"

  def complete(r,prefix,count)
    results = []
    rangelen = 100 # This is not random, try to get replies < MTU size
    start = r.zrank(:compl,prefix)
    return [] if !start
    while results.length != count
      range = r.zrange(:compl,start,start+rangelen-1)
      start += rangelen
      break if !range or range.length == 0
      range.each {|entry|
        minlen = [entry.length,prefix.length].min
        if entry[0...minlen] != prefix[0...minlen]
          count = results.count
          break
        end
        if entry[-1..-1] == "*" and results.length != count
          results << entry[0...-1]
        end
      }
    end
    return results
  end

  name = gets.chomp
  complete(r,name,100).each{|res|
    puts res
    puts "\n"
  }
  
end
