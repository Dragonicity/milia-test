class Blog < ApplicationRecord
  enum status: { draft: 0, published: 1 }
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :user
  belongs_to :topic
  has_many :comments, dependent: :destroy
  validates_presence_of :title, :body

  scope :reverse_date_order, -> { order("created_at DESC") }

  after_initialize :set_defaults

  def set_defaults
    self.thumb_nail ||= "http://placehold.it/350x200"
    self.main_image ||= "http://placehold.it/600x400"
  end

end