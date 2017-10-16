class Topic < ApplicationRecord
  has_many :blogs
  validates_presence_of :title

  scope :title_order, -> { order("topics.title ASC") }

  def self.with_blogs
    includes(:blogs).where.not(blogs: { id: nil } )
  end
end
