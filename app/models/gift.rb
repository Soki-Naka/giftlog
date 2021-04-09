class Gift < ApplicationRecord
  belongs_to :favorite_person, dependent: :destroy
  validates :favorite_person_id, presence: true
  validates :item, presence: true
end
