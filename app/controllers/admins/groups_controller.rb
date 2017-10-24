class Admins::GroupsController < ApplicationController
	before_action :authenticate_admin!
	before_action :find_group,only:[:show,:edit,:update,:destroy]
	before_action :not_delete,only:[:destroy]
	def index
		@groups = Group.all
		authorize @groups
	end

	def new
		@group = Group.new()
		authorize @group
	end

	def create
		@group = Group.new(params_group)
		if @group.save
			flash[:sucess]="Grupo ha creado con éxito"
			redirect_to admins_groups_path
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
		if @group.update(params_group)
			flash[:sucess]="Grupo actualizado con éxito"
			redirect_to admins_groups_path
		else
			render :new
		end	
	end

	def destroy
		if @group.destroy
			flash[:success]="Grupo eliminado correctamente"
		redirect_to admins_groups_path
		else
			redirect_to admins_groups_path
		end
	end

	def import
		@import_group = ImportGroup.new		
	end

	def group_import
		@import_group = ImportGroup.new(params[:import_group])
		if @import_group.save
			flash[:success]="El groupo se ha importado correctamente"
			redirect_to admins_groups_path
		else
			render :import
		end		
	end

	private
	def not_delete
		if @group.exams.present? || @group.events.present? || @group.assignments.present? || @group.home_works.present? || @group.schedules.present?
			flash[:error]="El grupo está siendo utilizado por una assignments o events o home_works y no puede ser removido."
			redirect_to admins_groups_path
		end
	end

	def find_group
		@group = Group.find_by(:id=> params[:id])
		authorize @group
	end
	def params_group
		params.require(:group).permit(:Group_ID,:description,:school_id)	
	end
end
