class Role < ApplicationRecord
	has_many :admins ,dependent: :destroy
end
