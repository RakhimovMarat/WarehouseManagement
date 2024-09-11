class AddressesController < ApplicationController
  before_action :find_address, only: %i[show]

  def index
    warehouse_id = params[:warehouse_id].to_i
    item_id = params[:item_id].to_i

    logger.debug "warehouse_id: #{warehouse_id}, item_id: #{item_id}"

    warehouse = Warehouse.find_by(id: warehouse_id)

    if item_id > 0
      addresses = warehouse.addresses.joins(:receipts)
                                     .where(receipts: { item_id: item_id })
                                     .distinct
      logger.debug "Filtered addresses: #{addresses.map(&:id)}"
    else
      addresses = warehouse.addresses
      logger.debug "All addresses: #{addresses.map(&:id)}"
    end

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
