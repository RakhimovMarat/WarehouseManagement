class ChangeRelocatedToInRelocates < ActiveRecord::Migration[7.1]
  def change
    remove_column :relocates, :relocated_to, :string

    add_reference :relocates, :relocated_to, foreign_key: { to_table: :addresses }, null: false
  end
end
