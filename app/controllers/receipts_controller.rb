class ReceiptsController < ApplicationController
  before_action :find_receipt, only: %i[show]

  def new
    @receipt = Receipt.new
    @addresses = Address.all
    @items = Item.all
  end

  def create
    @receipt = Receipt.new(receipt_params)
    if @receipt.save
      flash[:success] = 'Товар размещен'
      redirect_to @receipt
    else
      flash.now[:error] = 'Товар не размещен'
      render :new
    end
  end

  def show; end

  private

  def receipt_params
    params.require(:receipt).permit(:address_id, :item_id, :quantity)
  end

  def find_receipt
    @receipt = Receipt.find_by(id: params[:id])
  end
end
