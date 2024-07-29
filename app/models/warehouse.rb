class Warehouse < ApplicationRecord
  before_save :capitalize_name

  validates :name, presence: true, uniqueness: true

  has_many :addresses

  private

  def capitalize_name
    self.name = name.downcase.capitalize
  end
end
