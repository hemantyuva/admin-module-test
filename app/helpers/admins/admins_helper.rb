module Admins::AdminsHelper
	def get_image()
		current_admin.image.present? ? current_admin.image.url : ""
	end

	def get_role_by_admin
		if current_admin.role.try(:name) == "School manager" || current_admin.role.try(:name) == "School Assistant"
			Role.where(name: "Teachers")
		else
			Role.all
		end
	end

end
