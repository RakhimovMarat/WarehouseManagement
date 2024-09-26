class StocksController < ApplicationController
  def index
    @stocks = Stock.includes(:item, :address).all
  end
end
