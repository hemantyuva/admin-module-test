class AdminSubject < ApplicationRecord
	belongs_to :admin
	belongs_to :subject
end
