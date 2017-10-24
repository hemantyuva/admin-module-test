module Admins::CouponsHelper
	def get_coupon_image(coupon)
		coupon.image.present? ? coupon.image.url : ""		
	end
end
