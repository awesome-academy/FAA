require "rails_helper"

RSpec.describe Education::Comment, type: :model do
  context "associations" do
    it{is_expected.to belong_to :commentable}
    it{is_expected.to belong_to :user}
  end

  context "validations" do
    it{is_expected.to validate_presence_of :content}
    it do
      is_expected.to validate_length_of(:content)
        .is_at_most Settings.education.comment.max_content_length
    end
  end

  describe "get list comment" do
    let!(:user){FactoryGirl.create :user}
    let!(:project){FactoryGirl.create :project}
    let!(:comment1){FactoryGirl.create :comment, created_at: Time.now}
    let!(:comment2){FactoryGirl.create :comment, created_at: Time.now + 1.hour}
    comments = Education::Comment.newest
    it "returns list order comment" do
      expect(comments).to eq [comment2, comment1]
    end
  end
end
