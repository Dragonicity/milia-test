class Retreat < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates_presence_of :name, :start_date, :end_date
  scope :reverse_date_order, -> { order("created_at DESC") }

  mount_uploader :main_image, ImageUploader
  mount_uploader :thumb_nail, ImageUploader
end
