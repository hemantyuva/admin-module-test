class Admins::TeachersController < ApplicationController
	before_action :authenticate_admin!
	before_action :find_teacher,only:[:show,:edit,:update,:destroy,:update_profile]
	def index
		@teachers = Teacher.all
		
	end
	def new
		@teacher = Teacher.new
	end
	def create
		@teacher = Teacher.new(params_admin)
		if @teacher.save()
			redirect_to admins_teachers_path
		else
		   flash[:error]= @teacher.errors.messages
		   render :new
		end
		
	end
	def edit
		
	end
	def update
		if @teacher.update(params_teacher)
			redirect_to admins_teachers_path
		else
			flash[:error]= @teacher.errors.messages
			render :new
		end			
	end	
	def current_user
		current_admin		
	end
	helper_method :current_user
	

	def destroy
		if @teacher.destroy
		redirect_to admins_teachers_path
		else
			redirect_to admins_teachers_path
		end		
	end
	private
	def find_teacher
		@teacher = Teacher.find_by(:id=> params[:id])
	end
	def params_admin
		params.require(:teacher).permit(:email,:password,:password_confirmation,:first_name,:last_name, :gender, :picture, :status)	
	end
end
