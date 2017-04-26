FactoryGirl.define do
  factory :training, class: Education::Training do
    name Faker::Name.name
    description{Faker::Lorem.paragraphs(rand 5..8).join("")}
  end
end
