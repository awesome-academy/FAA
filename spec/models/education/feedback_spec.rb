require "rails_helper"

RSpec.describe Education::Feedback, type: :model do
  let(:education_feedback){FactoryGirl.create :education_feedback}

  describe "columns" do
    it{expect(education_feedback).to have_db_column(:name).of_type(:string)}
    it{expect(education_feedback).to have_db_column(:email).of_type(:string)}
    it do
      expect(education_feedback).to have_db_column(:phone_number)
        .of_type(:string)
    end
    it{expect(education_feedback).to have_db_column(:subject).of_type(:string)}
    it{expect(education_feedback).to have_db_column(:content).of_type(:text)}
  end

  describe "validation" do
    it{is_expected.to validate_presence_of(:name)}
    it do
      is_expected.to validate_length_of(:name)
        .is_at_most Settings.education.feedback.max_name_length
    end
    it{is_expected.to validate_presence_of(:email)}
    it do
      is_expected.to validate_length_of(:email)
        .is_at_most Settings.education.feedback.max_email_length
    end
    it do
      is_expected.to validate_length_of(:phone_number)
        .is_at_most Settings.education.feedback.max_phone_number_length
    end
    it{is_expected.to validate_presence_of(:subject)}
    it do
      is_expected.to validate_length_of(:subject)
        .is_at_least Settings.education.feedback.min_subject_length
    end
    it do
      is_expected.to validate_length_of(:subject)
        .is_at_most Settings.education.feedback.max_subject_length
    end
    it{is_expected.to validate_presence_of(:content)}
    it do
      is_expected.to validate_length_of(:content)
        .is_at_least Settings.education.feedback.min_content_length
    end
    it do
      is_expected.to validate_length_of(:content)
        .is_at_most Settings.education.feedback.max_content_length
    end
  end

  describe "get list feedback" do
    let!(:feedback1) do
      FactoryGirl.create :education_feedback, created_at: Time.now
    end
    let!(:feedback2) do
      FactoryGirl.create :education_feedback, created_at: Time.now + 1.hour
    end
    let!(:feedback3) do
      FactoryGirl.create :education_feedback, created_at: Time.now + 2.hours
    end
    feedbacks = Education::Feedback.newest
    it "returns list order feedback" do
      expect(feedbacks).to eq [feedback3, feedback2, feedback1]
    end
  end
end
