require 'sinatra'
require 'active_record'
require './app/models/restaurant'

require 'dotenv'
Dotenv.load

require 'rack-flash'
enable :sessions
set :session_secret, 'SOME LONG STRING TO USE FOR SESSION COOKIE ENCRYPTION'
use Rack::Flash

ActiveRecord::Base.establish_connection(adapter: 'postgresql',
                                        database: ENV['database'])

get '/restaurants/new' do
  erb :new_restaurant
end

post '/restaurants' do
  p params
  r = Restaurant.create! name: params["restaurant"]["name"],
                         location: params["restaurant"]["location"],
                         cuisine: params["restaurant"]["cuisine"]
  flash[:notice] =
    "Restaurant: #{r.name}, Located at #{r.location}, Cuisine: #{r.cuisine}!"
  redirect '/restaurants/new'
end

get '/restaurants' do
  @restaurants = Restaurant.all
  erb :restaurant_index
end

get '/restaurants/:id' do
  @restaurant = Restaurant.find(params[:id])
  erb :show_restaurant
end

delete '/restaurants/:id' do
  p params
  r = Restaurant.find_by(params[:id])
  r.destroy
end
