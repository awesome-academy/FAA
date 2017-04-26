FactoryGirl.define do
  factory :user do
    name{FFaker::Name.name}
    email{FFaker::Internet.email}
    phone{FFaker::PhoneNumber.phone_number}
    password "password"
    password_confirmation "password"
  end
end
