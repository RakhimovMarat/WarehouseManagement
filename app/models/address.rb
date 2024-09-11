class Address < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { scope: :warehouse_id }

  belongs_to :warehouse
  has_many :receipts, dependent: :destroy
  has_many :expenses, dependent: :destroy
end
