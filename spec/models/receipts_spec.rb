require 'rails_helper'

RSpec.describe Receipt, type: :model do
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
    let(:receipt)   { create(:receipt, item: item, address: address) }

    before do
      Stock.create(item: item, address: address, quantity: 10)
    end

    it 'calls update_stock callback after save' do
      expect(receipt).to receive(:update_stock)

      receipt.save
    end

    it 'increase stock quantity after item receipt' do
      stock = Stock.find_by(item: item, address: address)

      stock.update(quantity: stock.quantity + 5)
      expect(stock.quantity).to eq(15)
    end
  end
end
