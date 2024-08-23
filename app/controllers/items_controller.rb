class ItemsController < ApplicationController
  before_action :find_item, only: %i[show get_address put_item_on_address]

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

  def get_address
    @addresses = Address.where.missing(:items)
  end

  def put_item_on_address
    address_id = params[:item]&.dig(:address_id)
    @item.update(address_id: address_id)
    redirect_to @item
  end

  private

  def item_params
    params.require(:item).permit(:number, :description, :address_id)
  end

  def find_item
    @item = Item.find_by(id: params[:id] || params[:item_id])
  end
end
