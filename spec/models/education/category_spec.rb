require "rails_helper"

RSpec.describe Education::Category, type: :model do
  context "associations" do
    it{is_expected.to have_many :posts}
  end

  context "validates" do
    it{is_expected.to validate_presence_of :name}
    it{is_expected.to validate_length_of(:name).is_at_most(200)}
    it "is valid with a valid name" do
      expect(FactoryGirl.build(:education_category, name: "a" * 2)).to be_valid
    end
    it "is invalid with a long name" do
      expect(FactoryGirl.build(:education_category, name: "a" * 201))
        .not_to be_valid
    end
  end
end
