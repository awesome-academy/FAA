require "rails_helper"

RSpec.describe Education::Rate, type: :model do
  context "associations" do
    it{is_expected.to belong_to :rateable}
    it{is_expected.to belong_to :user}
  end

  it "validations" do
    is_expected.to validate_presence_of :rate
  end
end
