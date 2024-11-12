require 'rails_helper'

RSpec.describe RelocatesController, type: :controller do
  let(:user)         { create(:user) }
  let(:warehouse)    { create(:warehouse) }
  let(:item)         { create(:item) }
  let(:address_from) { create(:address, name: 'A-1-01', warehouse: warehouse) }
  let(:address_to)   { create(:address, name: 'A-2-02', warehouse: warehouse) }

  before do
    sign_in user

    Stock.create(item: item, address: address_from, quantity: 10)
    Stock.create(item: item, address: address_to, quantity: 2)
  end

  describe 'POST #create' do
    context 'with valid attributes' do
    
    let(:relocate_attributes) do
      {
        number: item.number,
        name: address_from.name,
        relocated_to: address_to.name,
        quantity: 5
      }
    end
    
    subject { post :create, params: { relocate: relocate_attributes } }

      it 'creates new relocate' do
        expect { subject }.to change(Relocate, :count).by(1)
      end

      it 'sets a success flash message' do
        subject
        expect(flash[:success]).to eq('Товар перемещен')
      end
    end

    context 'with invalid attributes' do
      let(:relocate_attributes) { attributes_for(:relocate, item: '') }
      subject { post :create, params: { relocate: relocate_attributes } }

      it 'does not create new relocate' do
        expect {subject}.not_to change(Relocate, :count)
      end

      it 'sets an error flash message' do
        subject
        expect(flash[:error]).to eq('Товар или адрес не найдены')
      end
    end
  end
end
