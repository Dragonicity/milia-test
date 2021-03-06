class Blog < ApplicationRecord
  acts_as_taggable
  enum status: { draft: 0, published: 1 }
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :user
  belongs_to :topic
  has_many :comments, dependent: :destroy
  validates_presence_of :title, :subtitle, :topic, :body

  mount_uploader :main_image, ImageUploader
  mount_uploader :thumb_nail, ImageUploader

  scope :reverse_date_order, -> { order("blogs.created_at DESC") }
end