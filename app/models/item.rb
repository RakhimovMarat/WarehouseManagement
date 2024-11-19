# frozen_string_literal: true

class Item < ApplicationRecord
  validates :number, presence: true, uniqueness: true
  validates :description, presence: true

  has_many :receipts, dependent: :destroy
  has_many :expenses, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :relocates, dependent: :destroy
  has_many :orders, dependent: :destroy
end
