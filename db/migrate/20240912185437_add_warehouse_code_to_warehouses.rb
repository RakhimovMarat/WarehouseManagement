# frozen_string_literal: true

class AddWarehouseCodeToWarehouses < ActiveRecord::Migration[7.1]
  def change
    add_column :warehouses, :warehouse_code, :string
  end
end
