class Coupon < ApplicationRecord
  belongs_to :merchant
  mount_uploader :image, ImageUploader
end
