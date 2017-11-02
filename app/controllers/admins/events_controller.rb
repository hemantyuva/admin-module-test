class Admins::EventsController < ApplicationController
	before_action :authenticate_admin!
	before_action :find_event,only:[:show,:edit,:update,:destroy]

	def index
		@events = Event.all
		#authorize @events
	end

	def new
		@event = Event.new()
		authorize @event		
	end
	def current_user
		current_admin		
	end
	helper_method :current_user

	def create		
		@event = Event.new(params_event)
		if @event.save
			d= if params[:event][:group_id].include?("todas_grupos")
				group = School.find_by(id: params[:event][:school_id]).groups.ids
				group.map{|x| {group_id: x}}
				
			else
				params[:event][:group_id].delete("")
				params[:event][:group_id].map{|x| {group_id: x}}
				
			end
			@event.event_groups.create(d)
			flash[:success]="evento creado correctamente"
			redirect_to admins_events_path
		else
			render :new
		end
	end

	def show
				
	end

	def edit
		
	end

	def update
		if @event.update(params_event)
			flash[:success]="evento actualizado con éxito"
			redirect_to admins_events_path
		else
			render :new
		end		
	end

	def destroy
		if @event.destroy
			flash[:success]="evento eliminado correctamente"
			redirect_to admins_events_path
		else
			redirect_to admins_events_path
		end	
	end

	def get_group_by_school
		@school = School.find(params[:school])
		if @school.present?
			render json: {"groups"=> @school.groups}
		else
			render json: {"groups"=> []}
		end		
	end

	private

	def find_event
		@event = Event.find_by(:id=> params[:id])
		authorize @event
	end
	def params_event
		params[:event][:admin_id] = current_admin.id
		params[:event][:added_by] = 1
		params.require(:event).permit(:title,:start_date,:end_date,:start_time,:end_time,:location,:event_type,:reminder,:description,:school_id,:notes,:admin_id,:added_by)	
	end
end
