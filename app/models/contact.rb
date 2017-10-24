class Contact < ApplicationRecord
	has_many :schools ,dependent: :destroy
	has_many :institutions ,dependent: :destroy
	validates_presence_of :first_name,:last_name,:email,:phone_number,:mobile_number
end
