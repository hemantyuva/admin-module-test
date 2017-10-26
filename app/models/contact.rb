class Contact < ApplicationRecord
	has_many :schools ,dependent: :destroy
	has_many :institutions ,dependent: :destroy
	validates_presence_of :first_name,:last_name,:email,:phone_number,:mobile_number
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
