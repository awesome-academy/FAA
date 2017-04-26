FactoryGirl.define do
  factory :company do
    name{FFaker::Company.name}
    website{FFaker::Internet.domain_name}
    introduction{FFaker::Lorem.sentence}
    founder{FFaker::Name.name}
    country{FFaker::Address.country}
    company_size 100
    founder_on{FFaker::Time.datetime}
  end
end
