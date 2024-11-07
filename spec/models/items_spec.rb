require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:number) }
    it { should validate_presence_of(:description) }
    it { should validate_uniqueness_of(:number) }
  end

  describe 'associations' do
    it { should have_many(:receipts).dependent(:destroy) }
    it { should have_many(:expenses).dependent(:destroy) }
    it { should have_many(:stocks).dependent(:destroy) }
    it { should have_many(:relocates).dependent(:destroy) }
    it { should have_many(:orders).dependent(:destroy) }
  end
end
