#from http://blog.trydionel.com/2010/02/27/lightning-quick-redis-viewer/
#(fixed a tiny bug!)

require 'rubygems'
require 'haml'
require 'sinatra'
require 'redis'

helpers do
  def redis
    @redis ||= Redis.new
  end
end

get "/" do
  @keys = redis.keys("*")
  haml :index
end

get "/:key" do
  @key = params[:key]
  @data = case redis.type(@key)
  when "string"
    Array(redis[@key])
  when "list"
    redis.lrange(@key, 0, -1)
  when "set"
    redis.smembers(@key)
  else
    []
  end
  haml :show
end