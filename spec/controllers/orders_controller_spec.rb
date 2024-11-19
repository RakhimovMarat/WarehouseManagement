require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user)  {create(:user)}
  let(:item)  {create(:item)}

  before do
    sign_in user
  end

  describe 'PATCH #update_quantity' do
    context 'when order has status "created" or "confirmed"' do
      let(:order) {create(:order, item: item)}
      let(:order_attributes) { { quantity: 100 } }

      before do
        patch :update_quantity, params: { id: order.id, order: order_attributes }
        order.reload
      end

      it 'update order quantity' do
        expect(order.quantity).to eq(100)
        expect(order.status).to eq('confirmed')
      end

      it 'sets a success flash message' do
        expect(flash[:success]).to eq('Данные изменены')
      end
    end

    context 'when order has no status "created" or "confirmed"' do
      let(:order) {create(:order, item: item, status: 'finished')}
      let(:order_attributes) { { quantity: 100 } }

      before do
        patch :update_quantity, params: { id: order.id, order: order_attributes }
        order.reload
      end

      it 'failed update order quantity' do
        expect(order.quantity).not_to eq(100)
      end

      it 'sets an error flash message' do
        expect(flash[:error]).to eq('Заказ не может быть изменен, так как его статус не позволяет этого')
      end
    end
  end

  describe 'PATCH #order_cancelation' do
    context 'when order is successfully canceled' do
      let(:order) { create(:order, item: item) }
      let(:order_attributes) { { status: 'canceled' } }

      before do
        patch :order_cancelation, params: { id: order.id, order: order_attributes }
        order.reload
      end

      it 'order cancelation' do
        expect(order.status).to eq('canceled')
      end

      it 'sets a success flash message' do
        expect(flash[:success]).to eq('Заказ отменен')
      end
    end
  end
end