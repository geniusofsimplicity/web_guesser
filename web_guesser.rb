require "sinatra"
require "sinatra/reloader"

set :number, rand(101)

get "/" do
	erb :index, {locals: {number: settings.number}}
end 