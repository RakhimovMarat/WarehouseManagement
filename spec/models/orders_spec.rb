# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    it { should belong_to(:item) }
  end

  describe 'Enums' do
    it {
      is_expected.to define_enum_for(:status).with_values(
        created: 0,
        confirmed: 1,
        finished: 2,
        canceled: 3
      )
    }

    it 'created as a default status' do
      order = Order.new
      expect(order.status).to eq('created')
    end
  end
end
