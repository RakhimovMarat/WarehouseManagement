class WarehousesController < ApplicationController
  before_action :find_warehouse, only: %i[show addresses information]

  def index
    if params[:item_id].present?
      item_id = params[:item_id].to_i
      @warehouses = Warehouse.joins(:addresses)
                             .joins(:receipts)
                             .where(receipts: { item_id: item_id })
                             .distinct
      render json: @warehouses
    else
      @warehouses = Warehouse.all
    end
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

  private

  def warehouse_params
    params.require(:warehouse).permit(:name)
  end

  def find_warehouse
    @warehouse = Warehouse.find_by(id: params[:id])
  end
end
