module Api
	module V1
		class HomeWorksController <  ApiController
			acts_as_token_authentication_handler_for User
			before_action :find_home_work,only:[:show,:destroy]
			def index
				if params[:admin_data].present?
					@home_works = HomeWork.where(school_id: current_user.school.id).all
				else
					@home_works = current_user.home_works.includes(:group,:school).all				
				end
			end

			def create
				@home_work = current_user.home_works.new(params_home_work)
				if @home_work.save
					render :show, status: 200
				else
					render json: {code: 500 , message: @home_work.errors.full_messages.first}
				end
			end

			def show
			end

			def destroy
				if @home_work.present?
					if @home_work.destroy
					render json: {code: 200 , message: "Home work deleted successfully"}
					else
						render json: {code: 500 , message: @home_work.errors.full_messages.first}
					end
				else
					render json: {code: 500 , message: "Home work not found"}
				end
			end

			private

			def find_home_work
				@home_work = current_user.home_works.find_by(:id=> params[:id])
			end

			def params_home_work
				params[:home_work][:school_id] = current_user.school.id
				params[:home_work][:added_by] = 0
				params.require(:home_work).permit(:deadline_date , :deadline_time , :description , :reminder , :subject_id , :title , :school_id , :group_id , :notes )
			end
		end
	end
end

