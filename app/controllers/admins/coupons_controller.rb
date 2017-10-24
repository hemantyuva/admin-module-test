class Admins::CouponsController < ApplicationController
	before_action :authenticate_admin!
	before_action :find_coupon,only:[:show,:edit,:update,:destroy]

	def index
		@coupons = Coupon.all
		authorize @coupons
	end

	def new
		@coupon = Coupon.new()
		authorize @coupon
	end

	def create
		begin
		
				params[:coupon][:merchant_id].delete("")
				if params[:coupon][:merchant_id].count >0
					params[:coupon][:merchant_id].each do |merchant|
						merchant1 = Merchant.find_by(id: merchant)
						@coupon = merchant1.coupons.new(params_coupon)
						if @coupon.save
							flash[:success]="cupón creado correctamente"									
						end			
						end
						redirect_to admins_coupons_path
					else
					flash[:error]="Seleccionar comerciante"
					redirect_to admins_coupons_path
				end
		rescue
			flash[:error]="Cupón no creado"
			redirect_to admins_coupons_path
		end
	end

	def show
				
	end

	def edit
		
	end

	def update
		if @coupon.update(params_coupon)
			flash[:success]="cupón actualizado con éxito"
			redirect_to admins_coupons_path
		else
			render :new
		end		
	end

	def destroy
		if @coupon.destroy
			flash[:success]="cupón eliminado correctamente"
			redirect_to admins_coupons_path
		else
			redirect_to admins_coupons_path
		end	
	end
	def current_user
		current_admin		
	end
	helper_method :current_user

	private

	def find_coupon
		@coupon = Coupon.find_by(:id=> params[:id])
		authorize @coupon
	end
	def params_coupon
		params.require(:coupon).permit( :title , :description , :image , :coupon_code , :begin_date , :expire_date , :total_coupon , :status )
	end
end
