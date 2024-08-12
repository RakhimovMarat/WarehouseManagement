class ItemsController < ApplicationController
  before_action :find_item, only: %i[show add_address]

  def index
    @items = Item.all
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

  def add_address
    @addresses = Address.all
    address_id = params[:item]&.dig(:address_id)
    @item.update(address_id: address_id)
  end

  private

  def item_params
    params.require(:item).permit(:number, :description, :address_id)
  end

  def find_item
    @item = Item.find_by(id: params[:id] || params[:item_id])
  end
end
