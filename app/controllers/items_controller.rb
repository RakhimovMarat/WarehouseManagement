class ItemsController < ApplicationController
  before_action :find_item, only: %i[show]

  def index
    @items = Item.all
    @grouped_items = Receipt.joins(:item, :address)
                            .select('items.id as item_id, items.number, items.description, addresses.name as address_name, warehouses.name as warehouse_name, SUM(receipts.quantity) as total_quantity')
                            .group('items.id, addresses.id, warehouses.id')
                            .joins(address: :warehouse)
                            .order('items.number')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = 'Новый товар создан'
      redirect_to @item
    else
      flash.now[:error] = 'Заполните все поля'
      render :new
    end
  end

  def show; end

  private

  def item_params
    params.require(:item).permit(:number, :description, :address_id)
  end

  def find_item
    @item = Item.find_by(id: params[:id] || params[:item_id])
  end
end
