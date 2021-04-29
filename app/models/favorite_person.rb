class FavoritePerson < ApplicationRecord
  belongs_to :user
  has_many :gifts, dependent: :destroy
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  mount_uploader :image, ImageUploader
  validates :description, length: { maximum: 200 }
  default_scope -> { order(created_at: :desc) }
end
