FactoryBot.define do
  factory :address do
    name { ('A'..'Z').to_a.sample  }
  end
end
