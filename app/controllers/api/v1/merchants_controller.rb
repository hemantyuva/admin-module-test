module Api
	module V1
		class MerchantsController <  ApiController
			acts_as_token_authentication_handler_for User
			before_action :find_home_work,only:[:show,:destroy]
			def index
				@merchants = current_user.school.merchants.all
			end

			def coupon_from_merchant
				@merchant = Merchant.find(params[:id])
				@coupons = @merchant.coupons.all
			end
		end
	end
end