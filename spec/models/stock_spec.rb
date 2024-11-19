# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Stock, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should belong_to(:address) }
    it { should belong_to(:item) }
  end
end
