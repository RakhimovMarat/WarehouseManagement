FactoryBot.define do
  factory :item do
    number           { 'A 000 111 222' }
    description      { 'Bolt' }
    minimal_quantity { 1 }
  end
end
