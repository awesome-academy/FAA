require "rails_helper"

RSpec.describe Education::Project, type: :model do
  context "associations" do
    it{is_expected.to have_many :rates}
    it{is_expected.to have_many :members}
    it{is_expected.to have_many :project_techniques}
    it{is_expected.to have_many :techniques}
    it{is_expected.to have_many :users}
    it{is_expected.to have_many :images}
  end

  context "validations" do
    it{is_expected.to validate_presence_of :name}
    it{is_expected.to validate_presence_of :description}
    it{is_expected.to validate_presence_of :core_features}
    it{is_expected.to validate_presence_of :release_note}
    it{is_expected.to validate_presence_of :plat_form}
    it{is_expected.to validate_presence_of :pm_url}
    it{is_expected.to validate_presence_of :server_info}
    it{is_expected.to validate_presence_of :git_repo}

    it do
      is_expected.to validate_length_of(:name)
        .is_at_most Settings.education.project.max_name_length
    end

    it "is invalid without name" do
      expect(FactoryGirl.build(:project, name: nil)).not_to be_valid
    end
    it "is invalid without description" do
      expect(FactoryGirl.build(:project, description: nil)).not_to be_valid
    end
    it "is invalid without core_features" do
      expect(FactoryGirl.build(:project, core_features: nil)).not_to be_valid
    end
    it "is invalid without release_note" do
      expect(FactoryGirl.build(:project, release_note: nil)).not_to be_valid
    end
    it "is invalid without plat_form" do
      expect(FactoryGirl.build(:project, plat_form: nil)).not_to be_valid
    end
    it "is invalid without pm_url" do
      expect(FactoryGirl.build(:project, pm_url: nil)).not_to be_valid
    end
    it "is invalid without server_info" do
      expect(FactoryGirl.build(:project, server_info: nil)).not_to be_valid
    end
    it "is invalid without git_repo" do
      expect(FactoryGirl.build(:project, git_repo: nil)).not_to be_valid
    end

    it "is invalid with a long name" do
      expect(FactoryGirl.build(:project,
        name: "a" * (Settings.education.project.max_name_length + 1)))
        .not_to be_valid
    end
    it "is invalid with a long server info" do
      expect(FactoryGirl.build(:project,
        name: "a" * (Settings.education.project.max_server_info_length + 1)))
        .not_to be_valid
    end
    it "is invalid with a long plat form" do
      expect(FactoryGirl.build(:project,
        name: "a" * (Settings.education.project.max_plat_form_length + 1)))
        .not_to be_valid
    end
    it "is invalid with a invalid git repo" do
      expect(FactoryGirl.build(:project,
        git_repo: "http://github")).not_to be_valid
    end
    it "is invalid with a invalid pm url" do
      expect(FactoryGirl.build(:project,
        pm_url: "http://order")).not_to be_valid
    end

    it "is valid with a valid name" do
      expect(FactoryGirl.build(:project,
        name: "a" * Settings.education.project.max_name_length)).to be_valid
    end
    it "is valid with a valid plat form" do
      expect(FactoryGirl.build(:project,
        plat_form: "a" * Settings.education.project.max_plat_form_length))
        .to be_valid
    end
    it "is valid with a valid server info" do
      expect(FactoryGirl.build(:project,
        server_info: "a" * Settings.education.project.max_server_info_length))
        .to be_valid
    end
    it "is valid with a valid git_repo" do
      expect(FactoryGirl.build(:project,
        git_repo: "http://github.com")).to be_valid
    end
    it "is valid with a valid pm_url" do
      expect(FactoryGirl.build(:project,
        pm_url: "http://order.framgia.com")).to be_valid
    end
  end

  describe "get list project" do
    let!(:project1){FactoryGirl.create :project, created_at: Time.now}
    let!(:project2){FactoryGirl.create :project, created_at: Time.now + 1.hour}
    let!(:project3){FactoryGirl.create :project, created_at: Time.now + 2.hours}
    projects = Education::Project.newest
    it "returns list order project" do
      expect(projects).to eq [project3, project2, project1]
    end
  end
end
