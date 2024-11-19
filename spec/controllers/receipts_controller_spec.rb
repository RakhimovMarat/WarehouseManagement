# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReceiptsController, type: :controller do
  let(:user)      { create(:user) }
  let(:warehouse) { create(:warehouse) }
  let(:item)      { create(:item) }
  let(:address)   { create(:address, name: 'A-1-01', warehouse: warehouse) }

  before do
    sign_in user

    Stock.create(item: item, address: address, quantity: 10)
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:receipt_attributes) { { number: item.number, name: address.name, quantity: 5 } }

      subject { post :create, params: { receipt: receipt_attributes } }

      it 'creates new receipt' do
        expect { subject }.to change(Receipt, :count).by(1)
      end

      it 'sets a success flash message' do
        subject
        expect(flash[:success]).to eq('Товар перемещен')
      end
    end

    context 'with invalid attributes' do
      let(:receipt_attributes) { attributes_for(:receipt, item: nil) }
      subject { post :create, params: { receipt: receipt_attributes } }

      it 'does not create new receipt' do
        expect { subject }.not_to change(Receipt, :count)
      end

      it 'sets an error flash message' do
        subject
        expect(flash[:error]).to eq('Товар или адрес не найдены')
      end
    end
  end
end
