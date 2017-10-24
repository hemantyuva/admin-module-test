module Api
	module V1
		class EventsController <  ApiController
			acts_as_token_authentication_handler_for User
			before_action :find_event,only:[:show,:destroy,:update]
			def index
				@events = Event.includes(:group,:school).all				
			end

			def create
				@event = Event.new(params_event)
				if @event.save
					render :show, status: 200
				else
					render json: {code: 500 , message: @event.errors.full_messages.first}
				end
			end

			def show
			end

			def update
				if @event.update(params_event)
					render :show, status: 200
				else
					render json: {code: 500 , message: @event.errors.full_messages.first}
				end				
			end

			def destroy
				if @event.present?
					if @event.destroy
					render json: {code: 200 , message: "Event deleted successfully"}
					else
						render json: {code: 500 , message: @event.errors.full_messages.first}
					end
				else
					render json: {code: 500 , message: "Event not found"}
				end
			end

			private

			def find_event
				@event = Event.find(params[:id])
			end

			def params_event
				params[:event][:school_id] = current_user.school.id
				params[:event][:added_by] = 0
				params[:event][:user_id] = current_user.id
				params.require(:event).permit(:title,:start_date,:end_date,:start_time,:end_time,:location,:event_type,:reminder,:description,:notes,:group_id,:added_by,:user_id,:school_id)
			end
		end
	end
end

