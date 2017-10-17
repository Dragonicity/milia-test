class Blog < ApplicationRecord
  enum status: { draft: 0, published: 1 }
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :user
  belongs_to :topic
  has_many :comments, dependent: :destroy
  validates_presence_of :title, :body

  mount_uploader :main_image, BlogUploader
  mount_uploader :thumb_nail, BlogUploader

  scope :reverse_date_order, -> { order("created_at DESC") }
end