class Relocate < ApplicationRecord
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :relocated_to, presence: true

  belongs_to :item
  belongs_to :address
  belongs_to :relocated_to, class_name: 'Address'

  after_save :update_stock
  before_save :check_stock

  private

  def update_stock
    stock_from = Stock.find_or_initialize_by(item: item, address: address)
    stock_from.quantity = (stock_from.quantity || 0) - quantity
    stock_from.save

    stock_to = Stock.find_or_initialize_by(item: item, address: relocated_to)
    stock_to.quantity = (stock_to.quantity || 0) + quantity
    stock_to.save
  end
end
