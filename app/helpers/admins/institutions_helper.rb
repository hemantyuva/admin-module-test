module Admins::InstitutionsHelper
	def get_institute_image(institution)
		institution.logo.present? ? institution.logo.url : ""
	end
	
	def get_institution
		arr = []
		current_admin.institutions.each do |int|
		arr <<	[int.try(:name), int.try(:id)]
		end
		return arr
		#[[current_admin.institution.try(:name),current_admin.institution.try(:id)]]
	end
end
