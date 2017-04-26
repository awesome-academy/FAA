FactoryGirl.define do
  factory :course_member, class: Education::CourseMember do
    user_id 1
    course_id 1
  end
end
