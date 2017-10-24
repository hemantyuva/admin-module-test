class Admins::ExamsController < ApplicationController
	before_action :authenticate_admin!
	before_action :find_exam,only:[:show,:edit,:update,:destroy]

	def index
		@exams = Exam.all
		authorize @exams
	end

	def new
		@exam = Exam.new()
		authorize @exam
	end

	def create
		@exam = Exam.new(params_exam)
		if @exam.save
			flash[:success]="examen creado correctamente"
			redirect_to admins_exams_path
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
		if @exam.update(params_exam)
			flash[:success]="examen actualizado con éxito"
			redirect_to admins_exams_path
		else
			render :new
		end		
	end

	def destroy
		if @exam.destroy
			flash[:success]="examen eliminado correctamente"
			redirect_to admins_exams_path
		else
			redirect_to admins_exams_path
		end	
	end

	private

	def find_exam
		@exam = Exam.find_by(:id=> params[:id])
		authorize @exam
	end
	def params_exam
		params[:exam][:admin_id] = current_admin.id
		params[:exam][:added_by] = 1
		params.require(:exam).permit( :exam_name , :exam_date , :start_time , :end_time , :place , :reminder , :notes , :school_id , :subject_id,:group_id,:classroom,:description,:admin_id,:added_by)
	end
end