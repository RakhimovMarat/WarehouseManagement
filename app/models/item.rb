class Item < ApplicationRecord
  validates :number, presence: true
  validates :number, uniqueness: true

  validates :description, presence: true

  has_many :receipts
end
