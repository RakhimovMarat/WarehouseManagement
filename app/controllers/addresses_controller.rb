class AddressesController < ApplicationController
  before_action :find_address, only: %i[show]

  def index
    warehouse = Warehouse.find(params[:warehouse_id])
    addresses = warehouse.addresses
    render json: addresses
  end

  def new
    @address = Address.new(warehouse_id: params[:warehouse_id])
    @warehouses = Warehouse.all
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      flash[:success] = 'Новый склад создан'
      redirect_to @address
    else
      flash.now[:error] = 'Заполните все поля'
      render :new
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
