module Api
	module V1
		class GroupsController <  ApiController
			acts_as_token_authentication_handler_for User
			def index
				@groups = current_user.school.groups.all
			end			
		end
	end
end