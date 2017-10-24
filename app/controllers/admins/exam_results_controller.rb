class Admins::ExamResultsController < ApplicationController
	before_action :authenticate_admin!
	before_action :find_exam_result,only:[:show,:edit,:update,:destroy]

	def index
		@exam_results = ExamResult.all
		authorize @exam_results
	end

	def new
		@exam_result = ExamResult.new()	
		authorize @exam_result	
	end

	def create
		@exam_result = ExamResult.new(params_exam_result)
		if @exam_result.save
			flash[:success]="resultado del examen creado correctamente"
			redirect_to admins_exam_results_path
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
		if @exam_result.update(params_exam_result)
			flash[:success]="resultado del examen actualizado con éxito"
			redirect_to admins_exam_results_path
		else
			render :new
		end		
	end

	def destroy
		if @exam_result.destroy
			flash[:success]="resultado del examen eliminado correctamente"
		redirect_to admins_exam_results_path
		else
			redirect_to admins_exam_results_path
		end	
	end

	private

	def find_exam_result
		@exam_result = ExamResult.find_by(:id=> params[:id])
		authorize @exam_result
	end
	def params_exam_result
		params.require(:exam_result).permit(:exam_id ,:user_id ,:score ,:abasent)
	end
end
