require "rails_helper"

RSpec.describe Education::HomeController, type: :controller do
  context "GET #index" do
    before do
      get :index
    end
    it{expect(response).to render_template(:index)}
    it{expect(response).to be_success}
  end
end
