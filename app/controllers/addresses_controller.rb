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
  
    if @address.valid?
      warehouse = Warehouse.find(@address.warehouse_id)
      @address.name = "#{warehouse.warehouse_code}-#{@address.name}"
    end
  
    if @address.save
      flash[:success] = 'Новый склад создан'
      redirect_to @address
    else
      flash[:error] = 'Заполните все поля'
      redirect_to new_address_path
    end

    # if @address.name.length > 5
    #   if @address.save
    #     flash[:success] = 'Новый склад создан'
    #     redirect_to @address
    #   else
    #     flash[:error] = 'Заполните все поля'
    #     redirect_to new_address_path
    #   end
    # else
    #   flash[:error] = 'Имя должно быть больше 5 символов'
    #   redirect_to new_address_path
    # end
  end

  def show; end

  def import_addresses
    @warehouses = Warehouse.all
  end

  def import
    file = params[:file]
    warehouse = Warehouse.find(params[:warehouse_id])

    if file.content_type == "text/csv"
      CsvImportAddressesService.new.call(file, warehouse)
      flash[:success] = 'Адреса загружены'
    else
      flash[:error] = 'Только файл формата csv'
    end
    redirect_to import_addresses_addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:name, :warehouse_id)
  end

  def find_address
    @address = Address.find_by(id: params[:id])
  end

end
