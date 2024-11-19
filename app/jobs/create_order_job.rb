# frozen_string_literal: true

class CreateOrderJob < ApplicationJob
  queue_as :default

  def perform(expense_id)
    expense = Expense.find(expense_id)
    item = expense.item
    stock_quantity = Stock.where(item_id: item.id).sum(:quantity)
    minimal_quantity = item.minimal_quantity

    if stock_quantity <= minimal_quantity && !order_for_item_exists?(item)
      order = Order.create(item_id: item.id, status: 'created')
      OrderMailer.order_created(order).deliver_now
    else
      p "==== Заказ не создан. Достаточное количество на складе: #{stock_quantity}, минимальное количество: #{minimal_quantity}"
    end
  end

  private

  def order_for_item_exists?(item)
    Order.exists?(item_id: item.id, status: %w[created confirmed])
  end
end
