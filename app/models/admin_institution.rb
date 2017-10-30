class AdminInstitution < ApplicationRecord
	belongs_to :admin
	belongs_to :institution
end
