class Gift < ApplicationRecord
  belongs_to :favorite_person
  validates :favorite_person_id, presence: true
  validates :item, presence: true, length: { maximum: 100 }
  validates :situation, length: { maximum: 50 }
  validates :price, length: { maximum: 30 }
  validates :when, length: { maximum: 50 }
  validates :description, length: { maximum: 200 }
  default_scope -> { order(created_at: :desc) }
end
