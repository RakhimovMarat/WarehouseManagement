class Item < ApplicationRecord
  validates :number, presence: true, uniqueness: true
  validates :description, presence: true

  belongs_to :address, optional: true
end
