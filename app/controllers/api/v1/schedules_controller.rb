module Api
	module V1
		class SchedulesController <  ApiController
			acts_as_token_authentication_handler_for User
			def index
				@schedules = Schedule.all
			end			
		end
	end
end