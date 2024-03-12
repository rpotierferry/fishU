class Fish < ApplicationRecord
  belongs_to :tank;
  validates :name, presence: true, length: {maximum: 6, message: "nkjzdhsdkjfhé"}
end
