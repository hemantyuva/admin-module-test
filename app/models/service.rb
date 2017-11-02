class Service < ApplicationRecord
	# belongs_to :school
	mount_uploader :photo, ImageUploader
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

	has_many :school_services, dependent: :destroy
    has_many :schools, :through => :school_services
    attr :school_id

end
