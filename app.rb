#from http://blog.trydionel.com/2010/02/27/lightning-quick-redis-viewer/
#(fixed a tiny bug!)

require 'rubygems'
require 'sinatra'
require 'redis'
require 'erb'

helpers do
  def redis
    @redis ||= Redis.new
  end
end

get '/' do
  erb :index
end

get '/search' do
  key =  params["key"];
  @results = redis.smembers(key)
  erb :search, :layout => !request.xhr?
end

