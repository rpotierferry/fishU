class Tank < ApplicationRecord
  belongs_to :user
  has_many :fish, dependent: :destroy
  has_many :plants, dependent: :destroy
end
