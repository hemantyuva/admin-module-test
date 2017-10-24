module Admins::EventsHelper
	def get_school_list
		current_admin.present? && current_admin.role.try(:name)=="Administrator" ? School.all : current_admin.schools		
	end
end
