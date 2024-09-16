class Item < ApplicationRecord
  validates :number, presence: true, uniqueness: true
  validates :description, presence: true

  has_many :receipts, dependent: :destroy
  has_many :expenses, dependent: :destroy
  has_many :stocks, dependent: :destroy
end
