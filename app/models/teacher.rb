class Teacher < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         mount_uploader :picture, ImageUploader
         enum status: [ :Inactivo, :Activo,:Suspendido,:Eliminado]
  		enum gender: [ :Male, :Female ]
end
