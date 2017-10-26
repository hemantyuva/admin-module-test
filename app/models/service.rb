class Service < ApplicationRecord
	belongs_to :school
	mount_uploader :photo, ImageUploader
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
