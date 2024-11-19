# frozen_string_literal: true

FactoryBot.define do
  factory :receipt do
    quantity { 5 }
    responsible { 'Username' }
  end
end
