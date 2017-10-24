class Merchant < ApplicationRecord
  # belongs_to :school
  has_many :merchant_schools ,dependent: :destroy
  has_many :schools ,through: :merchant_schools,dependent: :destroy
  has_many :coupons,dependent: :destroy
  mount_uploader :picture, ImageUploader
  attr :school_id
end
