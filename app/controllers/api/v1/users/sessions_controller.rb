class Api::V1::Users::SessionsController < Devise::OmniauthCallbacksController
	protect_from_forgery with: :null_session 
	respond_to :json

	def create
		# resource = User.find_for_database_authentication(login: params[:user][:email])
		resource = User.find_by(student_number: params[:user][:email])
		return invalid_login_attempt unless resource
		if resource.valid_password?(params[:user][:password])      
			sign_in("user", resource)      
			@user = current_user
			current_user.devices.where(:devise_type => params[:user][:devise_type], :token => params[:user][:token]).first_or_create
			respond_to do |format|
				format.json { render 'api/v1/users/show', status: :ok }
			end
			return
		end
		invalid_login_attempt
	end

	protected

	def ensure_params_exist
		return unless params[:user].blank?
		render :json => {:message => "missing user login parameter", :code => 422}
	end

	def invalid_social_login_attempt
		respond_to do |format|
			format.json { render :json => {message: "Enter your registered email id.", :code => 401} }
		end
	end

	def invalid_login_attempt
		respond_to do |format|
			format.json { render :json => {message: "Student Number Or Password not found.", :code => 401} }
		end    
	end  
end
