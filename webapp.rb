require 'rubygems'
require 'sinatra'
require 'sinatra/redis'
require 'erb'
require 'redis'

r = Redis.new

Pages = { 
  "1" => "starmonkey",
  "2" => "ham",
  "3" => "fox"
}

get "/" do
  erb :index
end

get "/page/:id" do |id|
  @subject = Pages[id]
  halt 404 unless @subject
  erb :page
end
 
error 404 do
  erb :error404
end

get '/foos' do
  @foos = r.smembers gets.chomp
  post @foos
end
