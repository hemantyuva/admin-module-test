class Admins::MerchantsController < ApplicationController
	before_action :authenticate_admin!
	before_action :find_merchant,only:[:show,:edit,:update,:destroy]
	before_action :not_delete,only:[:destroy]

	def index
		@merchants = Merchant.all
		authorize @merchants
	end

	def new
		@merchant = Merchant.new()
		authorize @merchant
	end

	def create
		begin
		@merchant = Merchant.new(params_merchant)
			if @merchant.save
				params[:merchant][:school_id].delete("")
				school = params[:merchant][:school_id].map{|x| {school_id: x}}
				@merchant.merchant_schools.create(school)
				flash[:success]="Proveedores creados con éxito"
				redirect_to admins_merchants_path
			else
				render :new
			end
		rescue
			flash[:error]="Lo sentimos. Algo ha fallado, inténtalo de nuevo."
			redirect_to admins_merchants_path
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
		if @merchant.update(params_merchant)
			flash[:success]="Proveedores actualizados con éxito"
			redirect_to admins_merchants_path
		else
			render :new
		end		
	end

	def destroy
		if @merchant.destroy
			flash[:success]="borrado exitosamente"
		redirect_to admins_merchants_path
		else
			redirect_to admins_merchants_path
		end	
	end

	private

	def not_delete
		if @merchant.coupons.present?
			flash[:error]="El merchant está siendo utilizado por una coupons y no puede ser removido."
			redirect_to admins_merchants_path
		end
	end

	def find_merchant
		@merchant = Merchant.find_by(:id=> params[:id])
		authorize @merchant
	end
	def params_merchant
		params.require(:merchant).permit(:name , :title , :description , :picture )	
	end
end
