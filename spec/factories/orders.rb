FactoryBot.define do
  factory :order do
    quantity { 0 }
    status   { 'created' }
  end
end