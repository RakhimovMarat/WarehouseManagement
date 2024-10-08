class AddressesController < ApplicationController
  before_action :find_address, only: %i[show]

  def new
    @address = Address.new(warehouse_id: params[:warehouse_id])
    @warehouses = Warehouse.all
    authorize @address
  end

  def create
    @address = Address.new(address_params)
    authorize @address
    warehouse = Warehouse.find(@address.warehouse_id)
    @address.name = "#{warehouse.warehouse_code}-#{@address.name}"

    if @address.name.length > 5
      @address.save
      flash[:success] = 'Новый склад создан'
      redirect_to @address
    else
      flash[:error] = 'Заполните все поля'
      redirect_to new_address_path
    end
  end

  def show; end

  private

  def address_params
    params.require(:address).permit(:name, :warehouse_id)
  end

  def find_address
    @address = Address.find_by(id: params[:id])
  end

end
