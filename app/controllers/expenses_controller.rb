class ExpensesController < ApplicationController
  before_action :find_expense, only: %i[show]

  def new
    @expense = Expense.new
    @addresses = Address.all
    @items = Item.all
  end

  def create
    @item = Item.find_by(number: params[:expense][:number])
    @address = Address.find_by(name: params[:expense][:name])

    if @item && @address
      @expense = Expense.new(expense_params.merge(item_id: @item.id, address_id: @address.id))

      if @expense.save
        flash[:success] = 'Товар выдан'
        redirect_to @expense
      else
        flash.now[:error] = 'Товар не выдан'
        render :new
      end
    else
      flash.now[:error] = 'Товар или адрес не найдены'
      render :new
    end
  end

  def show; end

  def expense_transactions
    @expense_transactions = Expense.joins(:item, :address)
                                   .includes(:item, :address)
                                   .order(created_at: :desc)
                                   .limit(10)
  end

  private

  def expense_params
    params.require(:expense).permit(:quantity)
  end

  def find_expense
    @expense = Expense.find_by(id: params[:id])
  end
end
