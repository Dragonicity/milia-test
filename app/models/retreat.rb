class Retreat < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates_presence_of :name, :start_date, :end_date

  scope :reverse_date_order, -> { order("retreats.created_at DESC") }
end
