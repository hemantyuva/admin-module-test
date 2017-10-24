module Admins::TeachersHelper
	def get_teacher_image(teacher)
		teacher.picture.present? ? teacher.picture.url	: ""	
	end
end
