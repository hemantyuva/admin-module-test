class Admins::SchoolClassesController < ApplicationController
	before_action :authenticate_admin!
	before_action :find_class,only:[:show,:edit,:update,:destroy]

	def index
		@school_classes = SchoolClass.all
	end

	def new
		@school_class = SchoolClass.new()		
	end

	def create
		@school_class = SchoolClass.new(params_class)
		if @school_class.save()
			redirect_to admins_school_classes_path
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
		if @school_class.update(params_class)
			redirect_to admins_school_classes_path
		else
			render :new
		end		
	end

	def destroy
		if @school_class.destroy
		redirect_to admins_school_classes_path
		else
			redirect_to admins_school_classes_path
		end	
	end

	private

	def find_class
		@school_class = SchoolClass.find_by(:id=> params[:id])
	end
	def params_class
		params.require(:school_class).permit( :name)	
	end
end
