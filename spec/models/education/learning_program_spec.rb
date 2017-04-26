require "rails_helper"

RSpec.describe Education::LearningProgram, type: :model do
  context "associations" do
    it{is_expected.to have_many :members}
    it{is_expected.to have_many :users}
  end

  context "validates" do
    it{is_expected.to validate_presence_of :name}
    it do
      is_expected.to validate_length_of(:name)
        .is_at_most Settings.education.index.max_learning_program_name
    end

    it "is valid with a valid name" do
      expect(FactoryGirl.build(:learning_program,
        name: "a" * Settings.education.index.max_learning_program_name))
        .to be_valid
    end

    it "is invalid without name" do
      expect(FactoryGirl.build(:learning_program, name: nil)).not_to be_valid
    end

    it "is invalid with a long name" do
      expect(FactoryGirl.build(:learning_program,
        name: "a" * (Settings.education.index.max_learning_program_name + 1)))
        .not_to be_valid
    end
  end
end
