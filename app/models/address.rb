class Address < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  belongs_to :warehouse
end
