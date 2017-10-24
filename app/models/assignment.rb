class Assignment < ApplicationRecord
  belongs_to :user
  belongs_to :school
  belongs_to :group
end
