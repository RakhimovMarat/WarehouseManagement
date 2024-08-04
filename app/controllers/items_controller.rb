class ItemsController < ApplicationController
  before_action :find_item, only: %i[show]

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

  private

  def item_params
    params.require(:item).permit(:number, :description, :address_id)
  end

  def find_item
    @item = Item.find_by(id: params[:id])
  end
end
