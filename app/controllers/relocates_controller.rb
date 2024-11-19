# frozen_string_literal: true

class RelocatesController < ApplicationController
  before_action :find_relocate, only: %i[show]

  def new
    @relocate = Relocate.new
  end

  def create
    @item = Item.find_by(number: params[:relocate][:number])
    @address_from = Address.find_by(name: params[:relocate][:name])
    @address_to = Address.find_by(name: params[:relocate][:relocated_to])

    if @item && @address_from && @address_to
      @relocate = Relocate.new(relocate_params.merge(
                                 item_id: @item.id,
                                 address_id: @address_from.id,
                                 relocated_to_id: @address_to.id
                               ))

      if @relocate.save
        flash[:success] = 'Товар перемещен'
        redirect_to @relocate
      else
        flash[:error] = @relocate.errors.full_messages.to_sentence
        redirect_to new_relocate_path
      end
    else
      flash[:error] = 'Товар или адрес не найдены'
      redirect_to new_relocate_path
    end
  end

  def show; end

  private

  def relocate_params
    params.require(:relocate).permit(:quantity)
  end

  def find_relocate
    @relocate = Relocate.find_by(id: params[:id])
  end
end
