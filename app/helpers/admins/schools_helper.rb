module Admins::SchoolsHelper

	def get_school_image(school)
		school.logo.present? ? school.logo.url : ""		
	end
end
