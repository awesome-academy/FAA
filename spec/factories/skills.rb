FactoryGirl.define do
  factory :skill do
    name{FFaker::Skill.tech_skills}
    describe{FFaker::Lorem.sentence}
  end
end
