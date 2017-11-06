class Admins::InstitutionsController < ApplicationController
	before_action :authenticate_admin!
	before_action :find_school,only:[:show,:edit,:update,:destroy]
	before_action :not_delete,only:[:destroy]

	def index
		@institutions = Institution.all
		authorize @institutions
	end

	def new
		@institution = Institution.new()
		authorize @institution
	end

	def create
		@institution = Institution.new(params_school)
		if @institution.save
			flash[:success]="Institución creada con éxito"
			redirect_to admins_institutions_path
		else
			flash[:error]= @institution.errors.messages
			render :new
		end
	end

	def show
				
	end

	def edit
		
	end
	def import
		@import_institute = ImportInstitute.new		
	end

	def institute_import
		@import_institute = ImportInstitute.new(params[:import_institute])
		if @import_institute.save
			flash[:success]="El instituteo se ha importado correctamente"
			redirect_to admins_institutions_path
		else
			render :import
		end		
	end
	def current_user
		current_admin		
	end
	helper_method :current_user

	def update
		if @institution.update(params_school)
			flash[:success]="Institución actualizada con éxito"
			redirect_to admins_institutions_path
		else
			flash[:error]= @institution.errors.messages
			render :new
		end		
	end

	def destroy
		if @institution.destroy
			flash[:success] = "Instituto eliminado correctamente"
		redirect_to admins_institutions_path
		else
			redirect_to admins_institutions_path
		end	
	end

	private
	# before_action :not_delete,only:[:destroy]

	def not_delete
		if @institution.schools.present? || @institution.users.present? 
			flash[:error]="El institutions está siendo utilizado por una schools y no puede ser removido."
			redirect_to admins_institutions_path
		end
	end

	def find_school
		@institution = Institution.find_by(:id=> params[:id])
		authorize @institution
	end
	def params_school
		longitude = {
		"longitude_coords_degrees"=>params[:longitude_coords_degrees],
		"longitude_coords_minutes"=>params[:longitude_coords_minutes],
		"longitude_coords_seconds"=>params[:longitude_coords_seconds],
		"longitude_compass"=>params[:longitude_compass],
		"full_longitude" => params[:longitude] 
	    }
	    latitude = {
		"latitude_coords_degrees"=>params[:latitude_coords_degrees],
		"latitude_coords_minutes"=>params[:latitude_coords_minutes],
		"latitude_coords_seconds"=>params[:latitude_coords_seconds],
		"latitude_compass"=>params[:latitude_compass],
		"full_latitude" => params[:latitude]
	    }
		params_value = params.require(:institution).permit(:name , :location , :description , :contact_personal , :contact_number , :email , :logo , :country , :state , :status , :contact_id)	
	    return params_value.merge!(:latitude =>  latitude, :longitude => longitude)
	end
end
