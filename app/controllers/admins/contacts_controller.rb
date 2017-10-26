class Admins::ContactsController < ApplicationController
	before_action :authenticate_admin!
	before_action :find_contact,only:[:show,:edit,:update,:destroy]
	before_action :not_delete,only:[:destroy]
	
	def index
		@contacts = Contact.all
		authorize @contacts
	end

	def new
		@contact = Contact.new()
		authorize @contact		
	end

	def create
		@contact = Contact.new(params_contact)
		if @contact.save
			flash[:success]="Contacto creado correctamente"
			redirect_to admins_contacts_path
		else
			flash[:error]= @contact.errors.messages
			render :new
		end
	end

	def show
				
	end

	def edit
		
	end

	def update
		if @contact.update(params_contact)
			flash[:success]="Contacto actualizado correctamente"
			redirect_to admins_contacts_path
		else
			flash[:error]= @contact.errors.messages
			render :new
		end		
	end

	def destroy
		if @contact.destroy
			flash[:success]="Contacto eliminado correctamente"
			redirect_to admins_contacts_path
		else
			redirect_to admins_contacts_path
		end	
	end
	def import
		@import_contact = ImportContact.new		
	end

	def contact_import
		@import_contact = ImportContact.new(params[:import_contact])
		if @import_contact.save
			flash[:success]="El contacto se ha importado correctamente"
			redirect_to admins_contacts_path
		else
			render :import
		end		
	end
	def current_user
		current_admin		
	end
	helper_method :current_user

	private
	def not_delete
		if @contact.schools.present? || @contact.institutions.present?
			flash[:error]="El contacto está siendo utilizado por una institución o escuela y no puede ser removido."
			redirect_to admins_contacts_path
		end
	end

	def find_contact
		@contact = Contact.find_by(:id=> params[:id])
		authorize @contact
	end
	def params_contact
		params.require(:contact).permit(:first_name , :last_name , :email , :phone_number , :mobile_number , :skype , :notes)	
	end
end
