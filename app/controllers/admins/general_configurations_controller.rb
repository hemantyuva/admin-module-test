class Admins::GeneralConfigurationsController < ApplicationController
	before_action :authenticate_admin!
	before_action :find_configuration,only:[:show,:edit,:update,:destroy]
	def index
		@configurations = GeneralConfiguration.all
		authorize @configurations
	end

	def new
		@configuration = GeneralConfiguration.new()
		authorize @configuration
	end

	def create
		@configuration = GeneralConfiguration.new(params_configuration)
		if @configuration.save
			flash[:success]="Configuración general creada correctamente"
			redirect_to admins_general_configurations_path
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
		if @configuration.update(params_configuration)
			flash[:success]="Configuración general actualizada correctamente"
			redirect_to admins_general_configurations_path
		else
			render :new
		end		
	end

	def destroy
		if @configuration.destroy
			flash[:success]="Configuración general eliminado correctamente"
			redirect_to admins_general_configurations_path
		else
			redirect_to admins_general_configurations_path
		end	
	end

	private

	def find_configuration
		@configuration = GeneralConfiguration.find_by(:id=> params[:id])
		authorize @configuration
	end
	def params_configuration
		params.require(:general_configuration).permit(:key_name,:value)	
	end
end
