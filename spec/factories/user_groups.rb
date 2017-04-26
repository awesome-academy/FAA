FactoryGirl.define do
  factory :user_group do
    user_id
    group_id
    is_default_group true
  end
end
