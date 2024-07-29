class AddWarehouseReferenceToAddress < ActiveRecord::Migration[7.1]
  def change
    add_reference :addresses, :warehouse, null: false, foreign_key: true
  end
end
