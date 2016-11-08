require "sinatra"
require "sinatra/reloader"

class Tracking	
	@@count = 5	
	def self.use
		@@count -= 1
		if @@count < 1
			@@count = 5			
			return true
		end
		false
	end
end

set :number, rand(101)
set :set_new_number, Proc.new { number = rand(101) }

helpers do
	def check_guess(guess = 0)		
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
	guess = params["guess"].scan(/\d*/).select{|v| v.size > 0}[0].to_i if params["guess"]
	message = check_guess(guess) if params["guess"]	
	number = settings.number
	reset = (Tracking.use && message != "correct!") || message == "correct!"
	settings.number = settings.set_new_number if reset
	erb :index, {locals: {number: number, message: message, reset: reset}}	
end