# frozen_string_literal: true

class Receipt < ApplicationRecord
  validates :quantity, presence: true, numericality: { greater_than: 0 }

  belongs_to :address
  belongs_to :item

  after_save :update_stock

  private

  def update_stock
    stock = Stock.find_or_initialize_by(item: item, address: address)
    stock.quantity = (stock.quantity || 0) + quantity
    stock.save
  end
end
