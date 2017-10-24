class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  acts_as_token_authenticatable
  # belongs_to :institution
  belongs_to :school
  has_many :events, dependent: :destroy# ,through: :school
  has_many :exams, dependent: :destroy
  has_many :exam_results, dependent: :destroy
  has_many :assignments, dependent: :destroy
  mount_uploader :picture, ImageUploader
  enum Status: [ :Inactivo, :Activo,:Suspendido,:Eliminado]
  enum gender: [ :Male, :Female ]

  has_many :devices, dependent: :destroy, inverse_of: :user
  has_many :home_works, dependent: :destroy
  accepts_nested_attributes_for :devices
  validates_presence_of :school_id,:first_name,:email,:password,:student_number,:gender,:school_Grade,:degree,:father_name,:father_email,:mother_name,:Status
  def self.find_for_database_authentication(warden_conditions)
  	conditions = warden_conditions.dup
  	if login = conditions.delete(:login)
  		where(conditions.to_hash).where(["lower(email) = :value", {:value => login.downcase}]).first
  	else
  		where(conditions.to_hash).first
  	end
  end 

  def self.user_per_month(month)
    day_in_month = month
    avil = self.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month).map{|x| x.created_at.day}
    over = (day_in_month-avil)
    found = []
    self.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month).group_by{|v| v.created_at.day}.each{|k,v| found << { :name => k , :y => v.count }}
    over.each{|v| found << { :name=>v, :y=>0}}
    result = found.sort_by{|x|  x.values[0]}
    return  result
  end
end
