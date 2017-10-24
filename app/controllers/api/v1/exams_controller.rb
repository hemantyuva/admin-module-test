module Api
	module V1
		class ExamsController <  ApiController
			acts_as_token_authentication_handler_for User
			before_action :find_exam,only:[:show,:destroy,:update]
			def index
				@exams = current_user.exams.includes(:group,:subject,:school).all				
			end

			def create
				@exam = current_user.exams.new(params_exam)
				if @exam.save
					render :show, status: 200
				else
					render json: {code: 500 , message: @exam.errors.full_messages.first}
				end
			end

			def show
			end

			def destroy
				if @exam.present?
					if @exam.destroy
					render json: {code: 200 , message: "Exam deleted successfully"}
					else
						render json: {code: 500 , message: @exam.errors.full_messages.first}
					end
				else
					render json: {code: 500 , message: "Exam not found"}
				end
			end
			def update	
				if @exam.update(params_exam)
					render :show, status: 200
				else
					render json: {code: 500 , message: @exam.errors.full_messages.first}
				end				
			end

			private

			def find_exam
				@exam = current_user.exams.find(params[:id])
			end

			def params_exam
				params[:exam][:school_id] = current_user.school.id
				params[:exam][:added_by] = 0
				params.require(:exam).permit(:exam_name,:exam_date,:start_time,:end_time ,:place ,:reminder ,:notes ,:school_id ,:subject_id ,:created_at ,:updated_at ,:group_id ,:classroom ,:description  ,:added_by ,:user_id )
			end
		end
	end
end