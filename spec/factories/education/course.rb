FactoryGirl.define do
  factory :course, class: Education::Course do
    name{Faker::Name.name}
    detail{Faker::Book.title}
    training_id{Education::Training.new}

    factory :invalid_course do
      name nil
    end
  end
end
