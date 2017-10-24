class Admins::RolesController < ApplicationController
	before_action :authenticate_admin!
	before_action :find_role,only:[:show,:edit,:update,:destroy]
	def index
		@roles = Role.all
		authorize @roles
	end

	def new
		@role = Role.new()
		authorize @role		
	end

	def create
		@role = Role.new(params_role)
		if @role.save!()
			redirect_to admins_roles_path
		else
			render :new
		end
	end

	def show
				
	end

	def edit
		
	end
	def current_user
		current_admin		
	end
	helper_method :current_user

	def update
		if @role.update(params_role)
			redirect_to admins_roles_path
		else
			render :new
		end		
	end

	def destroy
		if @role.destroy
		redirect_to admins_roles_path
		else
			redirect_to admins_roles_path
		end	
	end

	private

	def find_role
		@role = Role.find_by(:id=> params[:id])
		authorize @role
	end
	def params_role
		params.require(:role).permit(:name)	
	end
end
