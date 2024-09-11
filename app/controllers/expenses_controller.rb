class ExpensesController < ApplicationController
  before_action :find_expense, only: %i[show]

  def new
    @expense = Expense.new
    @items = Item.all
  end

  def create
    @expense = Expense.new(expense_params)
    if @expense.save
      flash[:success] = 'Товар списан'
      redirect_to @expense
    else
      flash.now[:error] = 'Товар не списан'
      render :new
    end
  end

  def show; end

  # def expense_transactions
  #   @expense_transactions = Expense.joins(:item, :address)
  #                                  .includes(:item, :address)
  #                                  .order(created_at: :desc)
  #                                  .limit(10)
  # end

  private

  def expense_params
    params.require(:expense).permit(:address_id, :item_id, :quantity)
  end

  def find_expense
    @expense = Expense.find_by(id: params[:id])
  end
end
