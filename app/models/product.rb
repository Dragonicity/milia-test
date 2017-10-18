class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  validates_presence_of :title, :description, :price

  mount_uploader :main_image, ProductUploader
  mount_uploader :thumb_nail, ProductUploader
end