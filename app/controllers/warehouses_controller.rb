class WarehousesController < ApplicationController
  before_action :find_warehouse, only: %i[show addresses information get_item add_item_to_address]

  def index
    @warehouses = Warehouse.all
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)
    if @warehouse.save
      flash[:success] = 'Новый склад создан'
      redirect_to @warehouse
    else
      flash.now[:error] = 'Заполните все поля'
      render :new
    end
  end

  def show; end

  def addresses
    @addresses = Address.where(warehouse_id: params[:id])
  end

  def information; end

  def get_item
    @items = Item.left_joins(:address).where('addresses.warehouse_id != ? OR items.address_id IS NULL', @warehouse.id)
    @addresses = Address.where(warehouse_id: @warehouse.id)
  end

  def add_item_to_address
    item_id = params[:warehouse][:item_id]
    address_id = params[:warehouse][:address_id]

    @item = Item.find(item_id)
    @address = Address.find(address_id)

    @item.update(address_id: @address.id)
    redirect_to @warehouse
  end

  private

  def warehouse_params
    params.require(:warehouse).permit(:name)
  end

  def find_warehouse
    @warehouse = Warehouse.find_by(id: params[:id])
  end
end
