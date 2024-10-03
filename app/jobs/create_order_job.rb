class CreateOrderJob < ApplicationJob
  queue_as :default

  def perform(expense_id)
    expense = Expense.find(expense_id)
    p "=== Раход номер #{expense.id} ==="

    item = expense.item
    p "=== Товар номер #{item.number} ==="

    stock_quantity = Stock.where(item_id: item.id).sum(:quantity)
    p "=== Остаток товара #{stock_quantity} ==="

    minimal_quantity = item.minimal_quantity
    p "=== Минимальный запас #{minimal_quantity} ==="

    if stock_quantity <= minimal_quantity && !order_for_item_exists?(item)
      order = Order.create(item_id: item.id, status: 'created')
      p "=== Заказ создан #{order.id} для товара #{item.number} ==="
    else
      p "==== Заказ не создан. Достаточное количество на складе: #{stock_quantity}, минимальное количество: #{minimal_quantity}"
    end
  end

  private

  def order_for_item_exists?(item)
    Order.exists?(item_id: item.id, status: ['created', 'confirmed'])
  end
end
