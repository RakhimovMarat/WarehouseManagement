# frozen_string_literal: true

class AddAddressReferenceToItem < ActiveRecord::Migration[7.1]
  def change
    add_reference :items, :address, null: false, foreign_key: true
  end
end
