class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         mount_uploader :image, ImageUploader
         belongs_to :role
         belongs_to :institution,optional: true

		 # belongs_to  :school,optional: true
		 has_many :admin_schools,dependent: :destroy
     has_many :schools, :through => :admin_schools
		 attr :school_id
end
