class Address < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { scope: :warehouse_id }

  belongs_to :warehouse
end
