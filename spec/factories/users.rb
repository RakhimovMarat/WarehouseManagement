FactoryBot.define do
  factory :user do
    username { 'user' }
    email    { 'user@user.com'}
    password { '12345678' }
    admin    { true }
  end
end
