FactoryGirl.define do
  factory :education_technique, class: Education::Technique do |f|
    f.name Faker::Name.last_name
    f.description Faker::Lorem.sentence
    factory :invalid_technique do
      name nil
    end
  end
end
