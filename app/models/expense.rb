class Expense < ApplicationRecord
  validates :quantity, presence: true, numericality: { greater_then: 0 }

  belongs_to :address
  belongs_to :item

  after_save :update_stock
  before_save :check_stock

  private

  def update_stock
    stock = Stock.find_or_initialize_by(item: item, address: address)
    stock.quantity = (stock.quantity || 0) - quantity
    stock.save
  end

  def check_stock
    stock = Stock.find_or_initialize_by(item: item, address: address)
    if stock.quantity < quantity
      errors.add(:quantity, "Не достаточно товара на адресе")
      throw(:abort)
    end
  end
end
