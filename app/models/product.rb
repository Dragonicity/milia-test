class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  validates :title, :description, :thumb_nail, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true

  validates :thumb_nail, :main_image, allow_blank: true, format: { 
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }

  mount_uploader :main_image, ProductUploader
  mount_uploader :thumb_nail, ProductUploader
end