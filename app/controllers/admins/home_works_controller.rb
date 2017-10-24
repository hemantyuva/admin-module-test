class Admins::HomeWorksController < ApplicationController
	before_action :authenticate_admin!
	before_action :find_home_work,only:[:show,:edit,:update,:destroy]

	def index
		@home_works = HomeWork.all
		authorize @home_works
	end

	def new
		@home_work = HomeWork.new()
		authorize @home_work
	end

	def create
		@home_work = HomeWork.new(params_home_work)
		if @home_work.save
			flash[:success]="tarea creada correctamente"
			redirect_to admins_home_works_path
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
		if @home_work.update(params_home_work)
			flash[:success]="tarea actualizada correctamente"
			redirect_to admins_home_works_path
		else
			render :new
		end		
	end

	def destroy
		if @home_work.destroy
			flash[:success]="Tarea borrada correctamente"
			redirect_to admins_home_works_path
		else
			redirect_to admins_home_works_path
		end	
	end

	private

	def find_home_work
		@home_work = HomeWork.find_by(:id=> params[:id])
		authorize @home_work
	end	
	def params_home_work
		params[:home_work][:admin_id] = current_admin.id
		params[:home_work][:added_by] = 1
		params.require(:home_work).permit(:deadline_date, :deadline_time, :description, :reminder, :subject_id,:title ,:school_id ,:group_id,:notes,:admin_id,:added_by)	
	end
end
