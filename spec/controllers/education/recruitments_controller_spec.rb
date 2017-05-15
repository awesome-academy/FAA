require "rails_helper"

RSpec.describe Education::RecruitmentsController, type: :controller do
  describe "GET #index" do
    it do
      get :index
      expect(response).to have_http_status :success
    end
  end
end
