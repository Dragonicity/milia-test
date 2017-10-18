class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  validates :title, description, price presence: true

  mount_uploader :main_image, ProductUploader
  mount_uploader :thumb_nail, ProductUploader
end