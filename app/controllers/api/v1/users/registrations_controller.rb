module Api
	module V1
		module Users
			class RegistrationsController < Devise::RegistrationsController
				protect_from_forgery with: :null_session 				

				def new
					super
				end

				def create
					@user = User.new(user_params)					
					if @user.save
						respond_to do |format|
							format.json { render 'api/v1/users/show', status: :ok }
						end
					else
						render json: {message: @user.errors.full_messages.first, code: 500}
					end
				end
				private
				def user_params
					params.require(:users).permit(:email, :first_name, :last_name,:password, :institution_id, :school_id, :devices_attributes => [:devise_type, :token])
				end
			end
		end
	end
end
