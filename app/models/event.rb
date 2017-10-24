class Event < ApplicationRecord
  belongs_to :school
  # belongs_to :group
  belongs_to :user,optional: true
  belongs_to :admin, optional: true
  has_many :event_groups,dependent: :destroy
  has_many :groups,through: :event_groups,dependent: :destroy
  attr :group_id
end
