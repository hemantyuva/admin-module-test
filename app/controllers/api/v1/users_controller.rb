module Api
	module V1
		class UsersController < ApiController
			acts_as_token_authentication_handler_for User
			before_action :set_user
			def update_profile
				respond_to do |format|
					if @user.update(update_params)
						format.json { render :show, status: 200 }
					else
						response_message @user.errors.full_messages.first, 500
					end
				end
			end

			def show
				
			end

			def log_out
		        @user.devices.destroy_all
		        sign_out @user
		        response_message "signed out", 200       
		      end

			private
			def set_user
				@user = current_user
			end

			def update_params
				params.require(:user).permit(:picture, :first_name,:last_name,:gender,:father_name,:father_email,:mother_name,:mother_email,:Status)
			end
		end
	end
end
