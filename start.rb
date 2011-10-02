require 'pp'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader' if development?
require './model/todo.rb'

helpers do
  include Rack::Utils; alias_method :h, :escape_html
end

get '/style.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :style
end

get '/' do
  @todos = Todos.order_by(:posted_date.desc)
  haml :index
end

post '/addtodo' do
  Todos.create({
    :todo => request[:todo],
    :posted_date => Time.now,
  })
  redirect '/'
end

post '/deltodo' do
  Todos.find(id: request[:id]).delete
  redirect '/'
end
