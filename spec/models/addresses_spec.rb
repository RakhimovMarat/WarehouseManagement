# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:warehouse) { create(:warehouse) }
  let(:address)   { create(:address, name: 'A-1-01', warehouse: warehouse) }

  describe 'validations' do
    subject { build(:address, warehouse: warehouse) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:warehouse_id) }
  end

  describe 'associations' do
    it { should belong_to(:warehouse) }
    it { should have_many(:receipts).dependent(:destroy) }
    it { should have_many(:expenses).dependent(:destroy) }
    it { should have_many(:stocks).dependent(:destroy) }
    it { should have_many(:relocates).dependent(:destroy) }
  end
end
