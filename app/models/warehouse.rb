# frozen_string_literal: true

class Warehouse < ApplicationRecord
  before_save :capitalize_name, :upcase_warehouse_code

  validates :name, presence: true, uniqueness: true
  validates :warehouse_code, presence: true, uniqueness: true

  has_many :addresses, dependent: :destroy
  has_many :receipts, through: :addresses
  has_many :expenses, through: :addresses

  private

  def capitalize_name
    self.name = name.downcase.capitalize if name.present?
  end

  def upcase_warehouse_code
    self.warehouse_code = warehouse_code.upcase if warehouse_code.present?
  end
end
