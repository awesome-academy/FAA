FactoryGirl.define do
  factory :education_post, class: Education::Post do
    title{FFaker::Lorem.sentence 2}
    content{FFaker::Lorem.paragraphs(rand 10..15).join("")}
    association :category, factory: :education_category
    user
  end
  factory :education_another_post, class: Education::Post do
    title{FFaker::Lorem.sentence 2}
    content{FFaker::Lorem.paragraphs(rand 10..15).join("")}
    association :category, factory: :education_category
    user
  end

  factory :new_education_post, class: Education::Post do
    title{FFaker::Lorem.sentence 2}
    content{FFaker::Lorem.paragraphs(rand 10..15).join("")}
  end

  factory :invalid_education_post, class: Education::Post do
    title nil
  end
end
