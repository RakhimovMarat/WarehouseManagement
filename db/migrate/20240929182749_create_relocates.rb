class CreateRelocates < ActiveRecord::Migration[7.1]
  def change
    create_table :relocates do |t|
      t.string :relocated_to
      t.string :responsible
      t.integer :quantity
      t.references :item, null: false, foreign_key: true
      t.references :address, null: false, foreign_key: true

      t.timestamps
    end
  end
end
