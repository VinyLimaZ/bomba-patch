class Team < ApplicationRecord
  validates :name, :description, presence: true
  has_one_attached :photo
end
