class Event < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 200 }
  validates :start_time, presence: true
end
