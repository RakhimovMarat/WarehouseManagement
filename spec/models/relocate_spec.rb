require 'rails_helper'

RSpec.describe Relocate, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:quantity).is_greater_than(0) }
    it { should validate_presence_of(:relocated_to) }
  end

  describe 'associations' do
    it { should belong_to(:item) }
    it { should belong_to(:address) }
    it { should belong_to(:relocated_to).class_name('Address') }
  end

  describe '#update_stock' do
    let(:warehouse)    { create(:warehouse) }
    let(:item)         { create(:item) }
    let(:address_from) { create(:address, name: 'A-1-01', warehouse: warehouse) }
    let(:address_to)   { create(:address, name: 'A-2-02', warehouse: warehouse) }
    let(:relocate)     { described_class.new(item: item, address: address_from, relocated_to: address_to, quantity: 5) }

    before do
      Stock.create(item: item, address: address_from, quantity: 10)
      Stock.create(item: item, address: address_to, quantity: 2)
    end

    it 'calls check_stock callback before save' do
      allow(relocate).to receive(:check_stock)

      relocate.save

      expect(relocate).to have_received(:check_stock)
    end

    it 'calls update_stock callback after save' do
      expect_any_instance_of(Relocate).to receive(:update_stock)

      relocate.save
    end

    it 'stock subtraction from dispatch address' do
      relocate.save

      stock_from = Stock.find_by(item: item, address: address_from)
      expect(stock_from.quantity).to eq(5)
    end

    it 'stock addition to destination address ' do
      relocate.save

      stock_to = Stock.find_by(item: item, address: address_to)
      expect(stock_to.quantity).to eq(7)
    end
  end
end
