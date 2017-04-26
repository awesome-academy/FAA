require "rails_helper"

RSpec.describe Tag, type: :model do
  describe "associations" do
    context "columns" do
      it{should have_db_column(:name).of_type(:string)}
    end

    context "associations" do
      it{expect have_many :taggable}
    end
  end

  describe "validations" do
    it{expect validate_presence_of(:name)}
  end
end
