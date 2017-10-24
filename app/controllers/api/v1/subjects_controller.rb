module Api
	module V1
		class SubjectsController <  ApiController
			acts_as_token_authentication_handler_for User
			def index
				@subjects = current_user.subjects.all
			end			
		end
	end
end