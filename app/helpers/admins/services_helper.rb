module Admins::ServicesHelper
	def get_service_image(service)
		service.photo.present? ? service.photo.url : ""		
	end
end
