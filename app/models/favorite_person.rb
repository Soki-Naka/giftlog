class FavoritePerson < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :name, presence: true
  mount_uploader :image, ImageUploader
end
