require 'bundler'
Bundler.require

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite://development.sqlite'

get '/' do
  erb :index
end

get '/things/' do
  @things = Things.all
  erb :things_index
end

get '/things/:id' do
  @thing = Thing.get(params[:id])
  erb :things_show
end

get '/things/new' do
  erb :things_new
end

post '/things' do
  @thing = Thing.new(params)
  @thing.save
  redirect '/things'
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
