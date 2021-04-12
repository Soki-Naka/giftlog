class FavoritePerson < ApplicationRecord
  belongs_to :user
  has_many :gifts, dependent: :destroy
  validates :user_id, presence: true
  validates :name, presence: true
  mount_uploader :image, ImageUploader
  default_scope -> { order(created_at: :desc) }
end
