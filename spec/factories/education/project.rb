FactoryGirl.define do
  factory :project, class: Education::Project do
    name Faker::Name.name
    description{Faker::Lorem.paragraphs(rand 5..8).join("")}
    core_features{Faker::Lorem.paragraphs(rand 5..8).join("")}
    release_note{Faker::Lorem.paragraphs(rand 5..8).join("")}
    server_info Faker::Lorem.sentence
    plat_form Faker::Lorem.sentence
    git_repo "https://github.com/example"
    pm_url "https://fportfolio.com/users/1"

    factory :invalid_project do
      name nil
    end
  end
end
