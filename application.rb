require 'bundler'
Bundler.require

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite")

class Thing
  include DataMapper::Resource
  
  property :id, Serial, :key => true
  property :title, String
  property :description, Text
end

get '/' do
  erb :index
end

get '/things' do
  @things = Thing.all
  erb :things_index
end

get '/things/new' do
  erb :things_new
end

post '/things' do
  @thing = Thing.create(params)
  @thing.save
  redirect '/things'
end

get '/things/:id' do
  @thing = Thing.get(params[:id])
  erb :things_show
end

get '/things/:id/edit' do
  @thing = Thing.get(params[:id])
  erb :things_edit
end

put '/things/:id' do
  @thing = Thing.get(params[:id])
  @thing.update(params)
  redirect "/things/#{params[:id]}"
end

delete '/things/:id' do
  Thing.get(params[:id]).destroy
  redirect '/things'
end
