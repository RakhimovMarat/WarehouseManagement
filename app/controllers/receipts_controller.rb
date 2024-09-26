class ReceiptsController < ApplicationController
  before_action :find_receipt, only: %i[show]

  def new
    @receipt = Receipt.new
    @addresses = Address.all
    @items = Item.all
  end

  def create
    @item = Item.find_by(number: params[:receipt][:number])
    @address = Address.find_by(name: params[:receipt][:name])

    if @item && @address
      @receipt = Receipt.new(receipt_params.merge(item_id: @item.id, address_id: @address.id))

      if @receipt.save
        flash[:success] = 'Товар размещен'
        redirect_to @receipt
      else
        flash.now[:error] = 'Товар не размещен'
        render :new
      end
    else
      flash.now[:error] = 'Товар или адрес не найдены'
      render :new
    end
  end

  def show; end

  def receipt_transactions
    @receipt_transactions = Receipt.joins(:item, :address)
                                   .includes(:item, :address)
                                   .order(created_at: :desc)
                                   .limit(10)
  end

  private

  def receipt_params
    params.require(:receipt).permit(:quantity)
  end

  def find_receipt
    @receipt = Receipt.find_by(id: params[:id])
  end
end
