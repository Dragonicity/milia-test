class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :blog

  validates :content, presence: true, ;ength: { minimum: 5, maximum: 1000 }
end
