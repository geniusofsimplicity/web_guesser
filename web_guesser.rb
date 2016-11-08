require "sinatra"
require "sinatra/reloader"

set :number, rand(101)

get "/" do
	"The secret number is #{options.number}"
end 