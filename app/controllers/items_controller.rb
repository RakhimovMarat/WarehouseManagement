class ItemsController < ApplicationController
  before_action :find_item, only: %i[show edit update]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    authorize @item
  end

  def create
    @item = Item.new(item_params)
    authorize @item
    if @item.save
      flash[:success] = 'Новый товар создан'
      redirect_to @item
    else
      flash[:error] = 'Заполните все поля'
      redirect_to new_item_path
    end
  end

  def show; end

  def edit
    authorize @item
  end

  def update
    authorize @item
    if @item.update(item_params)
      flash[:success] = 'Данные изменены'
      redirect_to @item
    else
      flash[:error] = 'Данные не изменены'
      redirect_to edit_item_path(@item)
    end
  end

  private

  def item_params
    params.require(:item).permit(:number, :description, :minimal_quantity)
  end

  def find_item
    @item = Item.find_by(id: params[:id] || params[:item_id])
  end
end
