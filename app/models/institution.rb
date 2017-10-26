class Institution < ApplicationRecord
	has_many :schools ,dependent: :destroy
	has_many :users , through: :schools,dependent: :destroy
	belongs_to :contact
    # belongs_to :admin
	mount_uploader :logo, ImageUploader
	enum status: [ :Inactivo, :Activo,:Suspendido,:Eliminado]
    validates_presence_of :name,:location,:contact_number,:email,:latitude,:longitude,:country,:state,:status,:contact_id
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	
    def self.institution_per_month(month)
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
