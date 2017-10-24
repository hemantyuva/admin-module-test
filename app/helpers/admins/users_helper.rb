module Admins::UsersHelper
	def get_user_image(user)
		user.picture.present? ? user.picture.url : ""
	end
end
