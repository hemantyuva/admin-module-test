module Admins::MerchantsHelper
	def get_merchant_image(merchant)
		merchant.picture.present? ? merchant.picture.url : ""		
	end
end
