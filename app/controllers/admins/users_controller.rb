class Admins::UsersController < ApplicationController
	before_action :authenticate_admin!
	before_action :find_school,only:[:show,:edit,:update,:destroy]
	before_action :not_delete,only:[:destroy]

	def index
		@users = User.includes(:school).all
		authorize @users
	end

	def new
		@user = User.new()
		authorize @user
	end

	def create
		@user = User.new(params_user)
		if @user.save
			flash[:success] = "Estudiante creado con éxito"
			redirect_to admins_users_path
		else
			flash[:error]= @user.errors.messages
			render :new
		end
	end

	def show
				
	end

	def edit
		
	end

	def import
		@import_user = ImportUser.new		
	end

	def user_import
		@import_user = ImportUser.new(params[:import_user])
		if @import_user.save
			flash[:success]="El usero se ha importado correctamente"
			redirect_to admins_users_path
		else
			render :import
		end		
	end
	def current_user
		current_admin		
	end
	helper_method :current_user

	def update
		if @user.update(params_user)
			flash[:success] = "Estudiante actualizado con éxito"
			redirect_to admins_users_path
		else
			flash[:error]= @user.errors.messages
			render :new
		end		
	end

	def destroy
		if @user.destroy
			flash[:success] = "Estudiante eliminado correctamente"
			redirect_to admins_users_path
		else
			redirect_to admins_users_path
		end	
	end

	private


	def not_delete
		if @user.exams.present? || @user.home_works.present? || @user.exam_results.present? || @user.assignments.present?  
			flash[:error]="El user está siendo utilizado por una exam o taria o schedule y no puede ser removido."
			redirect_to admins_users_path
		end
	end

	def find_school
		@user = User.find_by(:id=> params[:id])
		authorize @user
	end
	def params_user
		params.require(:user).permit(:email, :password,:password_confirmation,:first_name, :last_name, :institution_id, :school_id,:student_number,:gender,:picture,:school_Grade,:degree,:father_name,:father_email,:mother_name,:mother_email,:Status)	
	end
end

