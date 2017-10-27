class Teacher < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates_presence_of :name, :summary, :biography

  mount_uploader :main_image, ImageUploader
  mount_uploader :thumb_nail, ImageUploader
end