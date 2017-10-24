module Admins::InstitutionsHelper
	def get_institute_image(institution)
		institution.logo.present? ? institution.logo.url : ""
	end
	
	def get_institution
		[[current_admin.institution.try(:name),current_admin.institution.try(:id)]]
	end
end
