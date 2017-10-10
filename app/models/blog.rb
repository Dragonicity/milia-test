class Blog < ApplicationRecord
  enum status: { draft: 0, published: 1 }
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :user
  belongs_to :topic
  validates_presence_of :title, :body

  scope :recent_blogs, -> { order("created_at DESC") }
end