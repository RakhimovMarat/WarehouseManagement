class Order < ApplicationRecord
#  validates :quantity, numericality: { greater_than: 0 }

  enum :status, { created: 0, confirmed: 1, finished: 2, canceled: 3 }, default: :created

  belongs_to :item
end
