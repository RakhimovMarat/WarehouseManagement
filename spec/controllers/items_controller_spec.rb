require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:user) { create(:user) }
  let(:item) { create(:item) }

  before do
    sign_in user
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:item_attributes) { attributes_for(:item) }
      subject { post :create, params: { item: item_attributes } }

      it 'create new item' do
        expect { subject }.to change(Item, :count).by(1)
      end

      it 'sets a success flash message' do
        subject
        expect(flash[:success]).to eq('Новый товар создан')
      end
    end

    context 'with valid attributes' do
      let(:item_attributes) { attributes_for(:item, number: '') }
      subject { post :create, params: { item: item_attributes } }

      it 'does not create new item' do
        expect {subject}.not_to change(Item, :count)
      end

      it 'sets an error flash message' do
        subject
        expect(flash[:error]).to eq('Заполните все поля')
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      let(:item_attributes) { { number: 'Updated' } }

      before do
        patch :update, params: { id: item.id, item: item_attributes }
        item.reload
      end

      it 'update the item' do
        expect(item.number).to eq('Updated')
      end

      it 'sets a success flash message' do
        expect(flash[:success]).to eq('Данные изменены')
      end
    end
  end
end