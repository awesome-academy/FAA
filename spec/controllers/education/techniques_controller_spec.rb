require "rails_helper"
require "support/controller_helpers"

RSpec.describe Education::TechniquesController, type: :controller do
  let(:technique){FactoryGirl.create(:education_technique)}

  describe "GET #index" do
    before{get :index}

    context "render the show template" do
      it{expect(subject).to respond_with 200}
      it do
        expect(subject).to render_with_layout "education/layouts/application"
      end
      it{expect(subject).to render_template :index}
    end

    context "populates an array of techniques" do
      it{expect(assigns(:techniques)).to eq [technique]}
    end
  end
end
