require "rails_helper"

RSpec.describe Education::Technique, type: :model do
  let(:technique){FactoryGirl.build(:education_technique)}

  describe "columns" do
    it{expect(technique).to have_db_column(:name).of_type(:string)}
  end

  describe "associations" do
    it{expect(technique).to have_many :project_techniques}
    it{expect(technique).to have_many :projects}
    it{expect(technique).to have_one :image}
  end

  describe "show list technique" do
    let!(:technique1) do
      FactoryGirl.create :education_technique, created_at: Time.now
    end
    let!(:technique2) do
      FactoryGirl.create :education_technique, created_at: Time.now + 1.hour
    end
    technique = Education::Technique.newest
    it "returns list order technique" do
      expect(technique).to eq [technique2, technique1]
    end
  end
end
