require "sinatra"
require "sinatra/reloader"

set :number, rand(101)

helpers do
	def check_guess(guess)
		number = settings.number
		message = "too high!" if (1..10).include?(guess - number)
		message = "too low!" if (-10..-1).include?(guess - number)
		message = "way too high!" if (11..101).include?(guess - number)
		message = "way too low!" if (-101..-11).include?(guess - number)
		message = "correct!" if guess == number
		message	
	end
end


get "/" do
	guess = params["guess"].scan(/\d*/).select{|v| v.size > 0}[0].to_i
	message = check_guess(guess)
	number = settings.number
	erb :index, {locals: {number: number, message: message}}	
end 