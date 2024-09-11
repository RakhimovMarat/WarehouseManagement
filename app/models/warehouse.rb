class Warehouse < ApplicationRecord
  before_save :capitalize_name

  validates :name, presence: true, uniqueness: true

  has_many :addresses, dependent: :destroy
  has_many :receipts, through: :addresses
  has_many :expenses, through: :addresses

  private

  def capitalize_name
    self.name = name.downcase.capitalize
  end
end
