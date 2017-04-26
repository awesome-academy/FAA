require "rails_helper"

RSpec.describe Education::ProgramMember, type: :model do
  context "associations" do
    it{is_expected.to belong_to :learning_program}
    it{is_expected.to belong_to :user}
  end
end
