# frozen_string_literal: true

class CsvImportItemsService
  require 'csv'

  def call(file)
    file = File.open(file)
    csv = CSV.parse(file, headers: true, col_sep: ',')
    csv.each do |row|
      item_hash = {}
      item_hash[:number] = row['number']
      item_hash[:description] = row['description']
      item_hash[:minimal_quantity] = row['minimal_quantity']
      Item.create(item_hash)
    end
  end
end
