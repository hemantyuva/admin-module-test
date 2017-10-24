module Api
	module V1
		class ContactsController <  ApiController
			acts_as_token_authentication_handler_for User
			def index
				@contact = current_user.school.contact
			end			
		end
	end
end