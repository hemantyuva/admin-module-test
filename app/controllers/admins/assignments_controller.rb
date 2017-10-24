class Admins::AssignmentsController < ApplicationController
	before_action :authenticate_admin!
	before_action :find_assignment,only:[:show,:edit,:update,:destroy]

	def index
		@assignments = Assignment.all
		authorize @assignments
	end

	def new
		@assignment = Assignment.new()
		authorize @assignment
	end

	def create
		@assignment = Assignment.new(params_assignment)
		if @assignment.save()
			flash[:success]="Asignaciones creadas correctamente"
			redirect_to admins_assignments_path
		else
			render :new
		end
	end

	def show
				
	end

	def edit
		
	end

	def update
		if @assignment.update(params_assignment)
			flash[:success]="Asignaciones actualizadas con éxito"
			redirect_to admins_assignments_path
		else
			render :new
		end		
	end

	def destroy
		if @assignment.destroy
			flash[:success]="Asignaciones destroy successfully"
			redirect_to admins_assignments_path
		else
			flash[:error]="Vuelve a intentarlo."
			redirect_to admins_assignments_path
		end	
	end

	def import
		@import_assignment = ImportAssignment.new		
	end

	def assignment_import
		@import_assignment = ImportAssignment.new(params[:import_assignment])
		if @import_assignment.save
			flash[:success]="El Asignaciones se ha importado correctamente"
			redirect_to admins_assignments_path
		else
			render :import
		end		
	end

	def get_group_and_student
		@school = School.find(params[:school])
		if @school.present?
			render json: {"groups"=> @school.groups, "students"=>@school.users}
		else
			render json: {"groups"=> [], "students"=>[]}
		end		
	end
	def current_user
		current_admin		
	end
	helper_method :current_user

	private	

	def find_assignment
		@assignment = Assignment.find_by(:id=> params[:id])
		authorize @assignment
	end
	def params_assignment
		params.require(:assignment).permit(:user_id, :school_id,:group_id)
	end
end