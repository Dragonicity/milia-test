class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :blog

  validates :content, presence: true, length: { minimum: 5, maximum: 1000 }

  after_create_commit { CommentBroadcastJob.perform_later(self) }
end
