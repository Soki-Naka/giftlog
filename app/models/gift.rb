class Gift < ApplicationRecord
  belongs_to :favorite_person
  validates :favorite_person_id, presence: true
  validates :item, presence: true
  default_scope -> { order(created_at: :desc) }
end
