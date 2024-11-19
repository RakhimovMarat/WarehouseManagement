require 'rails_helper'

RSpec.describe ExpensesController, type: :controller do
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
      let(:expense_attributes) { { number: item.number, name: address.name, quantity: 3 } }

      subject { post :create, params: { expense: expense_attributes } }

      it 'creates new expense' do
        expect { subject }.to change(Expense, :count).by(1)
      end

      it 'sets a success flash message' do
        subject
        expect(flash[:success]).to eq('Товар выдан')
      end
    end

    context 'with invalid attributes' do
      let(:expense_attributes) { attributes_for(:expense, item: nil) }
      subject { post :create, params: { expense: expense_attributes } }

      it 'does not create new expense' do
        expect { subject }.not_to change(Expense, :count)
      end

      it 'sets an error flash message' do
        subject
        expect(flash[:error]).to eq('Товар или адрес не найдены')
      end
    end
  end
end