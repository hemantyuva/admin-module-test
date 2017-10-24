class Admins::SubjectsController < ApplicationController
	before_action :authenticate_admin!
	before_action :find_subject,only:[:show,:edit,:update,:destroy]
	before_action :not_delete,only:[:destroy]

	def index
		@subjects = Subject.all
		authorize @subjects
	end

	def new
		@subject = Subject.new()
		authorize @subject		
	end

	def create
		@subject = Subject.new(params_subject)
		if @subject.save()
			flash[:success]="tema actualizado con éxito"
			redirect_to admins_subjects_path
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
		if @subject.update(params_subject)
			flash[:success]="tema creado correctamente"
			redirect_to admins_subjects_path
		else
			render :new
		end		
	end

	def destroy
		if @subject.destroy
			flash[:success]="Borrado exitosamente"
			redirect_to admins_subjects_path
		else
			redirect_to admins_subjects_path
		end	
	end

	def import
		@import_subject = ImportSubject.new		
	end

	def subject_import
		@import_subject = ImportSubject.new(params[:import_subject])
		if @import_subject.save
			flash[:success]="El subjecto se ha importado correctamente"
			redirect_to admins_subjects_path
		else
			render :import
		end		
	end

	private
	def not_delete
		if @subject.exams.present? || @subject.home_works.present? || @subject.schedules.present? 
			flash[:error]="El school está siendo utilizado por una exam o taria o schedule y no puede ser removido."
			redirect_to admins_subjects_path
		end
	end

	def find_subject
		@subject = Subject.find_by(:id=> params[:id])
		authorize @subject
	end
	def params_subject
		params.require(:subject).permit( :name,:school_id,:Subject_ID,:description)	
	end
end
