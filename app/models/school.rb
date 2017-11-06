class School < ApplicationRecord
	belongs_to :institution
	belongs_to :contact
	has_many :users ,dependent: :destroy
	has_many :subjects ,dependent: :destroy

	 has_many :school_services,dependent: :destroy
     has_many :services, :through => :school_services
     attr :service_id


	has_many :groups ,dependent: :destroy
	has_many :events ,dependent: :destroy
	# has_many :assign_schools ,dependent: :destroy
	has_many :merchants ,dependent: :destroy
	mount_uploader :logo, ImageUploader
	enum status: [ :Inactivo, :Activo,:Suspendido,:Eliminado]
	validates_presence_of :name,:location,:latitude,:longitude,:institution_id,:status,:contact_id
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,:allow_blank => true 

def self.school_per_month(month)
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