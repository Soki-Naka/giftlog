class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :comment_likes, dependent: :destroy
  # has_many :liked_users, through: :comment_likes, source: :user
  validates :content, presence: true
  default_scope -> { order(created_at: :desc) }
end
