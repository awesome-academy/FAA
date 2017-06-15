FactoryGirl.define do
  factory :course_register do
    course_id{Education::Course.first.id}
    name{FFaker::Name.name}
    email{FFaker::Internet.email}
    phone_number "+84 913277422"
    address{FFaker::Address.street_address}
  end
end
