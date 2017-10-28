class Retreat < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name, :overview, :start_date, :end_date, presence: true

  scope :reverse_date_order, -> { order("retreats.created_at DESC") }
end
