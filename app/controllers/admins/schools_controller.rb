class Admins::SchoolsController < ApplicationController
	before_action :authenticate_admin!
	before_action :find_school,only:[:show,:edit,:update,:destroy]
	before_action :not_delete,only:[:destroy]
	def index
		if current_admin.role.try(:name)=="Administrator"
			@schools = School.includes(:institution).all
		else
			@schools = current_admin.schools.includes(:institution).all
		end
		authorize School
	end

	def new
		@school = School.new()
		authorize @school		
	end

	def create
		@school = School.new(params_school)
		if @school.save()
			flash[:success] = "Escuela creada con éxito"
			redirect_to admins_schools_path
		else
			flash[:error]= @school.errors.messages
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
		if @school.update(params_school)
			flash[:success] = "Escuela actualizada con éxito"
			redirect_to admins_schools_path
		else
			flash[:error]= @school.errors.messages
			render :new
		end		
	end

	def destroy
		if @school.destroy
			flash[:success]="Borrado exitosamente"
			redirect_to admins_schools_path
		else
			redirect_to admins_schools_path
		end	
	end

	def import
		@import_school = ImportSchool.new		
	end

	def school_import
		@import_school = ImportSchool.new(params[:import_school])
		if @import_school.save
			flash[:success]="El schoolo se ha importado correctamente"
			redirect_to admins_schools_path
		else
			render :import
		end		
	end

	private

	def not_delete
		if @school.users.present? || @school.subjects.present? || @school.services.present? || @school.groups.present? || @school.events.present? || @school.merchants.present?
			flash[:error]="El school está siendo utilizado por una users o subjects o services o groups y no puede ser removido."
			redirect_to admins_schools_path
		end
	end

	def find_school
		@school = School.find_by(:id=> params[:id])
		authorize @school
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
		"latitude_compass"=> params[:latitude_compass],
		"full_latitude" => params[:latitude]
	    }
		params_value = params.require(:school).permit(:name , :location , :description , :contact_personal , :contact_number , :email,:logo , :country , :state , :status , :contact_id,:institution_id)	
		return params_value.merge!(:latitude =>  latitude, :longitude => longitude)
	end
end

