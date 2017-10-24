class Schedule < ApplicationRecord
	belongs_to :subject
	belongs_to :group
	belongs_to :admin

end
