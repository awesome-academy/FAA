require "rails_helper"

RSpec.describe Education::Course, type: :model do
  context "associations" do
    it{is_expected.to have_many :course_members}
    it{is_expected.to have_many :users}
    it{is_expected.to have_many :images}
    it{is_expected.to belong_to :training}
  end

  context "validations" do
    it{is_expected.to validate_presence_of :name}
    it{is_expected.to validate_presence_of :detail}
    it do
      is_expected.to validate_length_of(:name)
        .is_at_most Settings.education.course.max_name_length
    end

    it "is valid with a valid name" do
      expect(FactoryGirl.build(:course,
        name: "a" * Settings.education.course.max_name_length)).to be_valid
    end

    it "is invalid without name" do
      expect(FactoryGirl.build(:course, name: nil)).not_to be_valid
    end

    it "is invalid with a long name" do
      expect(FactoryGirl.build(:course,
        name: "a" * (Settings.education.course.max_name_length + 1)))
        .not_to be_valid
    end
  end

  describe "show list course" do
    let!(:training){FactoryGirl.create :training}
    let!(:course1){FactoryGirl.create :course, created_at: Time.now}
    let!(:course2){FactoryGirl.create :course, created_at: Time.now + 1.hour}
    course = Education::Course.newest
    it "returns list order course" do
      expect(course).to eq [course2, course1]
    end
  end

  it "returns list course follower training" do
    training = FactoryGirl.create :training
    course1 = FactoryGirl.create :course, training: training
    expect(Education::Course.relation_training(training.id))
      .to include(course1)
  end

  describe "scope" do
    let!(:training){FactoryGirl.create :training}
    let!(:training1){FactoryGirl.create :training}
    let!(:course1) do
      FactoryGirl.create :course, name: "Course 1", training_id: training1.id
    end
    let!(:course2) do
      FactoryGirl.create :course, name: "Course 2", training_id: training.id
    end
    let!(:course3) do
      FactoryGirl.create :course, name: "Joo", training_id: training.id
    end

    it "by_training" do
      courses = Education::Course.by_training(training)
      expect(courses).to eq [course2, course3]
    end

    it "search by name" do
      courses = Education::Course.search(name_cont: "Cou").result
      expect(courses).to eq [course1, course2]
    end

    it "search by name and training" do
      courses = Education::Course.by_training(training.id)
        .search(name_cont: "Cou").result
      expect(courses).to eq [course2]
    end
  end
end
