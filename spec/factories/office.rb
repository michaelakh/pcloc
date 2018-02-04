FactoryBot.define do
  factory :office do
    name Faker::Company.name
    county  Faker::Address.country
    country  Faker::Address.country
    postcode  Faker::Address.postcode
    street_ad  Faker::Address.street_address
    town_city  Faker::Address.city
    phone_no  Faker::PhoneNumber.phone_number
  end

end
  