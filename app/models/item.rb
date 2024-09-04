class Item < ApplicationRecord
  validates :number, presence: true
  validates :number, uniqueness: { scope: :address_id }

  validates :description, presence: true

  belongs_to :address, optional: true
  has_many :receipts
end
