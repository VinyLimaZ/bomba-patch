class Team < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :description, presence: true
  has_one_attached :photo
end
