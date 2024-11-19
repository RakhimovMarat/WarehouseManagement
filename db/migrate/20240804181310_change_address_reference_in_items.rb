# frozen_string_literal: true

class ChangeAddressReferenceInItems < ActiveRecord::Migration[7.1]
  def change
    change_column_null :items, :address_id, true
  end
end
