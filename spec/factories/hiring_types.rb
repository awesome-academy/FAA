FactoryGirl.define do
  factory :hiring_type do
    name{FFaker::Name.name}
    description FFaker::Lorem.paragraph
    status 1
  end
end
