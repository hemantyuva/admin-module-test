class Admins::SchedulesController < ApplicationController
	before_action :authenticate_admin!
	before_action :find_schedule,only:[:show,:edit,:update,:destroy]
	def index
		@schedules = Schedule.all
		authorize @schedules
	end

	def new
		@schedule = Schedule.new()
		authorize @schedule
	end

	def create
		@schedule = Schedule.new(params_schedule)
		if @schedule.save
			flash[:success] = "Programa creado correctamente"
			redirect_to admins_schedules_path
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
		if @schedule.update(params_schedule)
			flash[:success] = "Programa actualizado con éxito"
			redirect_to admins_schedules_path
		else
			render :new
		end		
	end

	def destroy
		if @schedule.destroy
			flash[:success] = "Programa eliminado correctamente"
			redirect_to admins_schedules_path
		else
			redirect_to admins_schedules_path
		end	
	end

	private

	def find_schedule
		@schedule = Schedule.find_by(:id=> params[:id])
		authorize @schedule
	end
	def params_schedule
		params.require(:schedule).permit(:ClassRoom,:Monday,:Tuesday,:Wednesday,:Thursday,:Friday,:Saturday,:subject_id,:group_id,:admin_id)	
	end
end
