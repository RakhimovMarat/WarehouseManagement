class Receipt < ApplicationRecord
  validates :quantity, presence: true, numericality: { greater_then: 0 }

  belongs_to :address
  belongs_to :item
end
