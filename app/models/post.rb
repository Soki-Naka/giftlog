class Post < ApplicationRecord
  belongs_to :user
  has_many :post_likes, dependent: :destroy
  has_many :liked_users, through: :post_likes, source: :user
  default_scope -> { order(created_at: :desc) }
  has_many :comments, dependent: :destroy
  has_many :commented_users, through: :comments, source: :user
  validates :user_id, presence: true
  validates :who, presence: true, length: { maximum: 50 }
  validates :gender, presence: true
  validates :age, presence: true
  validates :job, length: { maximum: 50 }
  validates :situation, presence: true
  validates :item, presence: true, length: { maximum: 100 }
  mount_uploader :image, ImageUploader
  validates :price, presence: true
  validates :when, length: { maximum: 50 }
  validates :description, length: { maximum: 200 }
end
