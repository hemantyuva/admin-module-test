class Api::V1::Users::PasswordsController < Devise::PasswordsController
	protect_from_forgery with: :null_session
	respond_to :json 
	def create
		@user = User.find_by_email(params[:users][:email])
		if @user.present?
			@user.send_reset_password_instructions
			if successfully_sent?(@user)
				render :status => 200, :json => {:message => "reset password token sent to email"}
			else
				render :status => 422, :json => {:errors => @user.errors.full_messages}
			end
		else
			render :status => 422, :json => {:errors => 'no such email'}
		end
	end
	def update
		self.resource = resource_class.reset_password_by_token(resource_params)
		yield resource if block_given?
		if resource.errors.empty?
			resource.unlock_access! if unlockable?(resource)
			if Devise.sign_in_after_reset_password
				flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
				set_flash_message!(:notice, flash_message)
				sign_in(resource_name, resource)
				@user = resource
				respond_to do |format|
					format.json { render 'api/v1/users/show', status: :ok }
				end
				return
			else
				set_flash_message!(:notice, :updated_not_active)
			end
			respond_with resource, location: after_resetting_password_path_for(resource)
		else
			set_minimum_password_length
			respond_with resource
		end
	end
end
