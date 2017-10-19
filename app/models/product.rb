class Product < ApplicationRecord
  has_many :line_items

  before_destroy :ensure_no_line_items

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

  private

  def ensure_no_line_items
    unless line_items.empty?
      errors.add(:base, 'Line items present')
      throw :abort  
    end
  end

end