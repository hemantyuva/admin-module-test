module Api
	module V1
		class ServicesController <  ApiController
			acts_as_token_authentication_handler_for User
			def index
				@services = current_user.school.services.all
			end

			def show
				@service = current_user.school.services.find_by(id: params[:id])
			end
		end
	end
end