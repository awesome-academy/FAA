FactoryGirl.define do
  factory :address do
    company_id 1
    address FFaker::Address.city
    head_office 1
  end
end
