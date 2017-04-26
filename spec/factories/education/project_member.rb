FactoryGirl.define do
  factory :project_member, class: Education::ProjectMember do
    user_id 1
    project_id 1
  end
end
