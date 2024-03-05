class Fish < ApplicationRecord
  belongs_to :tank
  validates :name, presence: true
end
