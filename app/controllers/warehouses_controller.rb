# frozen_string_literal: true

class WarehousesController < ApplicationController
  before_action :find_warehouse, only: %i[show addresses information]

  def index
    @warehouses = Warehouse.all
  end

  def new
    @warehouse = Warehouse.new
    authorize @warehouse
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)
    authorize @warehouse
    if @warehouse.save
      flash[:success] = 'Новый склад создан'
      redirect_to @warehouse
    else
      flash[:error] = 'Заполните все поля'
      redirect_to new_warehouse_path
    end
  end

  def show; end

  def addresses
    @addresses = Address.where(warehouse_id: params[:id])
  end

  def information; end

  private

  def warehouse_params
    params.require(:warehouse).permit(:name, :warehouse_code)
  end

  def find_warehouse
    @warehouse = Warehouse.find_by(id: params[:id])
  end
end
