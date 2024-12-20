# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :number
      t.string :description

      t.timestamps
    end
  end
end
