require 'rails_helper'

RSpec.describe Expense, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:quantity).is_greater_than(0) }
  end

  describe 'associations' do
    it { should belong_to(:item) }
    it { should belong_to(:address) }
  end

  describe '#update_stock' do
    let(:warehouse) { create(:warehouse) }
    let(:item)      { create(:item) }
    let(:address)   { create(:address, name: 'A-1-01', warehouse: warehouse) }
    let(:expense)   { create(:expense, item: item, address: address) }

    before do
      Stock.create(item: item, address: address, quantity: 10)
    end

    it 'calls check_stock callback before save' do
      allow(expense).to receive(:check_stock)

      expense.save

      expect(expense).to have_received(:check_stock)
    end

    it 'calls update_stock callback after save' do
      expect(expense).to receive(:update_stock)

      expense.save
    end

    it 'reduce stock quantity after item receipt' do
      stock = Stock.find_by(item: item, address: address)

      stock.update(quantity: stock.quantity - 5)
      expect(stock.quantity).to eq(5)
    end
  end
end
