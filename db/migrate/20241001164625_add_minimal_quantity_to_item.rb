class AddMinimalQuantityToItem < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :minimal_quantity, :integer
  end
end
