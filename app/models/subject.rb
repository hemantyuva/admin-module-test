class Subject < ApplicationRecord
  belongs_to :school
  has_many :exams,dependent: :destroy
  has_many :home_works,dependent: :destroy
  has_many :schedules,dependent: :destroy
  validates_presence_of :name,:Subject_ID,:school_id,:description


 has_many :admin_subjects ,dependent: :destroy
 has_many :admin, :through => :admin_subjects
 attr :admin_id
end
