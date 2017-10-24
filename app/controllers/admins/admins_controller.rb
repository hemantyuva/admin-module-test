class Admins::AdminsController < ApplicationController
	before_action :authenticate_admin!
	before_action :find_admin,only:[:show,:edit,:update,:destroy]
	before_action :not_delete,only:[:destroy]
	def index
		if current_admin.role.try(:name) == "Administrator"
		# @admins = Admin.all
		@admins = Admin.where.not(id: current_admin)
		authorize Admin
		else
			array = []
			ids = current_admin.schools.ids
			adminschools = AdminSchool.ransack(school_id_in: ids).result
			adminschools.map{|x| array << x.admin_id if x.admin.role.try(:name) == "Teachers"}
			if array.present?
				@admins = Admin.ransack(id_in: array).result
			else
				@admins = []
			end
			authorize Admin
		end
		
		
	end
	def new
		@admin = Admin.new
		authorize @admin
	end
	def create
		@admin = Admin.new(params_admin)
		if @admin.save
			params[:admin][:school_id].each do |f|
				@admin.admin_schools.create(:school_id=> f)
			end
			
			flash[:success]="Admin creadas correctamente"
			redirect_to admins_admins_path
		else
			render :new
		end
		
	end
	def edit
		admin = Admin.find(params[:id])
        @institution = admin.institution
		@schools = admin.schools
		@admin = admin
	end

	def get_school_by_institution
		institute = Institution.find_by(:id=> params[:institution])
		if institute.present?
			render json: {"schools"=> institute.schools}
		else
			render json: {"schools"=> []}
		end	
	end

	def update
		if @admin.update(params_admin)
			AdminSchool.find_by_admin_id(@admin.id).update_attributes(school_id: params[:admin][:school_id].last)
			flash[:success]="Admin actualizadas con éxito"
			redirect_to admins_admins_path
		else
			render :new
		end			
	end
	def get_profile
		@profile = current_admin
	end
	def update_profile
		if current_admin.update(:name=> params[:admin][:name],:image=> params[:admin][:image])
			flash[:success]="perfil actualizado con éxito"
			redirect_to root_path
		else
			flash[:error]="Vuelve a intentarlo."
			redirect_to root_path
		end
	end

	def destroy
		if @admin.destroy
			flash[:success]="admin eliminado correctamente"
			redirect_to admins_admins_path
		else
			flash[:error]="Vuelve a intentarlo."
			redirect_to admins_admins_path
		end		
	end
	def current_user
		current_admin		
	end
	helper_method :current_user
	private
	def not_delete
		if @admin.role.name == "Administrator"
			flash[:error]="No se puede eliminar admin."
			redirect_to admins_admins_path
		elsif @admin.schools.present? || @admin.institution.present?
			flash[:error]="Admin está siendo utilizado por una institución o escuela y no puede ser removido."
			redirect_to admins_admins_path
		end
	end
	def find_admin
		@admin = Admin.find_by(:id=> params[:id])
		authorize @admin
	end
	def params_admin
		params.require(:admin).permit(:name,:email,:password,:password_confirmation,:image,:role_id,:institution_id)	
	end
end
