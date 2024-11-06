require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:warehouse_code) }
    it { should validate_uniqueness_of(:warehouse_code) }
  end

  describe 'associations' do
    it { should have_many(:addresses).dependent(:destroy) }
    it { should have_many(:receipts).through(:addresses) }
    it { should have_many(:expenses).through(:addresses) }
  end

  describe 'before_save callbacks' do
    let(:warehouse) { create :warehouse }

    it 'capitalizes the name before saving' do
      warehouse.save
      expect(warehouse.name).to eq('Warehouse')
    end

    it 'upcases the warehouse_code before saving' do
      warehouse.save
      expect(warehouse.warehouse_code).to eq('WH123')
    end
  end
end
