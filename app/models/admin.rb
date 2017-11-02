class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         mount_uploader :image, ImageUploader
         belongs_to :role
         # belongs_to :institution,optional: true

		 # belongs_to  :school,optional: true
		 has_many :admin_schools,dependent: :destroy
     has_many :schools, :through => :admin_schools
		 attr :school_id

     has_many :admin_subjects,dependent: :destroy
     has_many :subjects, :through => :admin_subjects
     attr :subject_id

     has_many :admin_institutions,dependent: :destroy
     has_many :institutions, :through => :admin_institutions
     attr :institution_id
     # validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

end
