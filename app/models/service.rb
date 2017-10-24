class Service < ApplicationRecord
	belongs_to :school
	mount_uploader :photo, ImageUploader
end
