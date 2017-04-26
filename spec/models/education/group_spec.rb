require "rails_helper"

RSpec.describe Education::Group, type: :model do
  context "associations" do
    it{is_expected.to have_many :permissions}
    it{is_expected.to have_many :user_groups}
    it{is_expected.to have_many :users}
  end

  describe "get trainers by name" do
    let!(:trainer){FactoryGirl.create :education_group}
    it "get trainers" do
      trainers = Education::Group.get_trainers
      expect(trainers).to eq trainer
    end
  end
end
