# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    name { ('A'..'Z').to_a.sample }
  end
end
