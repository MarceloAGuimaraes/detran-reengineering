FactoryBot.define do
  factory :user, class: User do
    email { Faker::Internet.email }
    name {  Faker::Name.name }
    cpf { Faker::PhoneNumber.subscriber_number(length: 10) }
    birth_date { Faker::Date.between(from: '1900-09-12', to: '2000-09-12') }
    password { 'computador' }
    password_confirmation { 'computador' }
  end
end