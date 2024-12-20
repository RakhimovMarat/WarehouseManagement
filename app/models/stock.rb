# frozen_string_literal: true

class Stock < ApplicationRecord
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :address
  belongs_to :item
end
