class Blog < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :user
  validates :title, :body, presence: true
end
