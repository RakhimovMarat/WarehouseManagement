require 'rails_helper'

RSpec.describe WarehousesController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:warehouse_attributes) { attributes_for(:warehouse) }
      subject { post :create, params: { warehouse: warehouse_attributes } }

      it 'creates new warehouse' do
        expect { subject }.to change(Warehouse, :count).by(1)
      end

      it 'sets a success flash message' do
        subject
        expect(flash[:success]).to eq('Новый склад создан')
      end
    end

    context 'with invalid attributes' do
      let(:warehouse_attributes) { attributes_for(:warehouse, invalid_attribute: 'invalid value') }

      it 'does not create new warehouse' do
        expect {subject}.not_to change(Warehouse, :count)
      end

      it 'sets an error flash message' do
        subject
        expect(flash[:error]).to eq('Заполните все поля')
      end
    end
  end
end
