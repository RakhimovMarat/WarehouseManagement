class OrdersController < ApplicationController
  before_action :find_order, only: %i[show edit update_quantity get_order order_cancelation]
  def index
    @orders = Order.all
  end

  def show; end

  def edit
    authorize @order
  end

  def update_quantity
    authorize @order
    if @order.status.in?(["created", "confirmed"])
      if @order.update(order_params)
        @order.update(status: 'confirmed')
        flash[:success] = 'Данные изменены'
        redirect_to @order
      else
        flash[:error] = 'Данные не изменены'
        redirect_to edit_item_path(@order)
      end
    else
      flash[:error] = 'Заказ не может быть изменен, так как его статус не позволяет этого'
      redirect_to @order
    end
  end

  def get_order
    authorize @order
  end

  def order_cancelation
    authorize @order
    if @order.update(status: 'canceled')
      flash[:success] = 'Заказ отменен'
      redirect_to @order
    else
      flash[:error] = 'Заказ не отменен'
      redirect_to order_path(@order)
    end
  end

   private

  def order_params
    params.require(:order).permit(:quantity, :status)
  end

  def find_order
    @order = Order.find_by(id: params[:id])
  end
end
