# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def check_stock
    stock = Stock.find_or_initialize_by(item: item, address: address)

    if stock.new_record?
      errors.add(:base, 'Товар отсутствует на данном адресе')
    elsif stock.quantity < quantity
      errors.add(:quantity, 'Не достаточно товара на адресе')
    end

    throw(:abort) if errors.any?
  end
end
