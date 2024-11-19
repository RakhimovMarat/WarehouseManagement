# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateOrderJob, type: :job do
  let(:item)      { create(:item, number: '123', minimal_quantity: 10) }
  let(:warehouse) { create(:warehouse) }
  let(:address)   { create(:address, name: 'A-1-01', warehouse: warehouse) }
  let(:expense)   { create(:expense, item: item, address: address, quantity: 3) }

  before do
    allow(OrderMailer).to receive_message_chain(:order_created, :deliver_now)
  end

  context 'when stock quantity is less than or equal to minimal quantity' do
    before do
      Stock.create(item: item, address: address, quantity: 12)
    end

    it 'creates an order and sends an email' do
      expect do
        described_class.perform_now(expense.id)
      end.to change(Order, :count).by(1)

      order = Order.last
      expect(order.item_id).to eq(item.id)
      expect(order.status).to eq('created')
      expect(OrderMailer).to have_received(:order_created).with(order)
    end
  end

  context 'when stock quantity is greater than minimal quantity' do
    before do
      Stock.create(item: item, address: address, quantity: 15)
    end

    it 'does not create an order' do
      expect do
        described_class.perform_now(expense.id)
      end.not_to change(Order, :count)
    end
  end

  context 'when an order for the item already exists' do
    before do
      Stock.create(item: item, address: address, quantity: 5)
      Order.create(item: item, status: 'created')
    end

    it 'does not create a duplicate order' do
      expect do
        described_class.perform_now(expense.id)
      end.not_to change(Order, :count)
    end
  end
end
