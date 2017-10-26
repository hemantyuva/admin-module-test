class Admins::ServicesController < ApplicationController
	before_action :authenticate_admin!
	before_action :find_service,only:[:show,:edit,:update,:destroy]
	def index
		@services = Service.includes(:school).all
		authorize @services
	end

	def new
		@service = Service.new()
		authorize @service
	end

	def create
		@service = Service.new(params_service)
		if @service.save()
			flash[:success]="servicio creado correctamente"
			redirect_to admins_services_path
		else
			flash[:error]= @service.errors.messages
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
		if @service.update(params_service)
			flash[:success]="servicio actualizado con éxito"
			redirect_to admins_services_path
		else
			flash[:error]= @service.errors.messages
			render :new
		end		
	end

	def destroy
		if @service.destroy
		redirect_to admins_services_path
		else
			redirect_to admins_services_path
		end	
	end

	private

	def find_service
		@service = Service.find_by(:id=> params[:id])
		authorize @service
	end
	def params_service
		params.require(:service).permit(:title,:photo,:description,:email,:phone_number,:school_id,:link,:Document_Link,:Notes)	
	end
end
