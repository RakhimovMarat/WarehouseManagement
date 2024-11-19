# frozen_string_literal: true

class CsvImportAddressesService
  require 'csv'

  def call(file, warehouse)
    file = File.open(file)
    csv = CSV.parse(file, headers: true, col_sep: ',')
    csv.each do |row|
      item_hash = row.to_hash
      item_hash['name'] = "#{warehouse.warehouse_code}-#{item_hash['name']}"

      Address.create!(item_hash.merge(warehouse_id: warehouse.id))
    end
  end
end
