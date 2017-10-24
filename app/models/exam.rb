class Exam < ApplicationRecord
  belongs_to :school
  belongs_to :subject
  belongs_to :group
  belongs_to :user,optional: true
  belongs_to :admin, optional: true
end
