FactoryGirl.define do
  factory :education_category, class: Education::Category do
    name{FFaker::Name.name}
  end
end
