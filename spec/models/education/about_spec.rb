require "rails_helper"

RSpec.describe Education::About, type: :model do
  context "associations" do
    it{is_expected.to have_one :image}
  end

  context "validates" do
    it{is_expected.to validate_presence_of :title}
    it{is_expected.to validate_presence_of :content}
  end

  context "accept nested attributes" do
    it{is_expected.to accept_nested_attributes_for :image}
  end
end
