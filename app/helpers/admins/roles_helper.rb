module Admins::RolesHelper
	def admin_access
		(current_admin.role.present?) and (current_admin.role.name == "Administrator")
	end

	def admin_sm_sas_access
		(current_admin.role.present?) and (current_admin.role.name == "Administrator" || current_admin.role.name == "School manager") || current_admin.role.name == "School Assistant" 
	end

	def only_promotion_access
	  (current_admin.role.present?) and (current_admin.role.name == "Promotions manager")
	end

	def promotion_access
		
		(current_admin.role.present?) and (current_admin.role.name == "Administrator" || current_admin.role.name == "Promotions manager")
	end

	def promotion_ssst_access
		(current_admin.role.present?) and (current_admin.role.name == "School manager" || current_admin.role.name == "School Assistant" || current_admin.role.name == "Teachers")
	end

	def admin_s_manager_access
		(current_admin.role.present?) and (current_admin.role.name == "Administrator" || current_admin.role.name == "School manager")
	end
	def p_manager_access
		Role.find_by(name: "Promotions manager")
	end

	def school_assistent_access
		Role.find_by(name: "Promotions manager")
	end

	def only_school_assistent_access
		(current_admin.role.present?) and (current_admin.role.name == "School Assistant")
	end

	def admin_all_access
		(current_admin.role.present?) and (current_admin.role.name == "Administrator" || current_admin.role.name == "School manager" || current_admin.role.name == "School Assistant" || current_admin.role.name == "Teachers")
	end
end
