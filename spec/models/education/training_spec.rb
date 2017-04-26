require "rails_helper"

RSpec.describe Education::Training, type: :model do
  context "associations" do
    it{is_expected.to have_many :courses}
    it{is_expected.to have_many :images}
    it{is_expected.to have_many :training_techniques}
    it{is_expected.to have_many :techniques}
  end

  context "validations" do
    it{is_expected.to validate_presence_of :name}
    it{is_expected.to validate_presence_of :description}
    it do
      is_expected.to validate_length_of(:name)
        .is_at_most Settings.education.training.max_name_length
    end

    it "is valid with a valid name" do
      expect(FactoryGirl.build(:training,
        name: "a" * Settings.education.training.max_name_length)).to be_valid
    end

    it "is invalid without name" do
      expect(FactoryGirl.build(:training, name: nil)).not_to be_valid
    end

    it "is invalid with a long name" do
      expect(FactoryGirl.build(:training,
        name: "a" * (Settings.education.training.max_name_length + 1)))
        .not_to be_valid
    end

    it "is invalid without description" do
      expect(FactoryGirl.build(:training, description: nil)).not_to be_valid
    end
  end

  describe "get list training" do
    let!(:training1){FactoryGirl.create :training, created_at: Time.now}
    let!(:training2) do
      FactoryGirl.create :training, created_at: Time.now + 1.hour
    end
    let!(:training3) do
      FactoryGirl.create :training, created_at: Time.now + 2.hours
    end
    trainings = Education::Training.newest
    it "returns list training ordered" do
      expect(trainings).to eq [training3, training2, training1]
    end
  end
end
