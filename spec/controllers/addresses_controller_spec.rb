require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  let(:user)      { create(:user) }
  let(:warehouse) { create(:warehouse) }

  before do
    sign_in user
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:address_attributes) { attributes_for(:address, warehouse_id: warehouse.id) }
      subject { post :create, params: { address: address_attributes } }

      it 'creates new address' do
        expect { subject }.to change(Address, :count).by(1)
      end

      it 'sets a success flash message' do
        subject
        expect(flash[:success]).to eq('Новый склад создан')
      end
    end

    context 'with invalid attributes' do
      let(:address_attributes) { attributes_for(:address, name: nil, warehouse_id: warehouse.id) }
      subject { post :create, params: { address: address_attributes } }

      it 'does not create new address' do
        expect { subject }.not_to change(Address, :count)
      end

      it 'sets an error flash message' do
        subject
        expect(flash[:error]).to eq('Заполните все поля')
      end
    end
  end

end