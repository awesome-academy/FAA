FactoryGirl.define do
  factory :education_permission, class: Education::Permission do
    entry "Education::Project"
    optional{{create: true, read: true, update: true, destroy: true}}
    association :group, factory: :education_group
  end
end
