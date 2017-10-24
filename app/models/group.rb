class Group < ApplicationRecord
  belongs_to :school
  has_many :exams ,dependent: :destroy
  has_many :event_groups ,dependent: :destroy
  has_many :events,through: :event_groups,dependent: :destroy
  has_many :assignments ,dependent: :destroy
  has_many :home_works ,dependent: :destroy
  has_many :schedules ,dependent: :destroy
  validates_presence_of :Group_ID,:school_id
end
