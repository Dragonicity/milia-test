class Lead < ApplicationRecord
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }

  scope :reverse_date_order, -> { order("leads.created_at DESC") }
end