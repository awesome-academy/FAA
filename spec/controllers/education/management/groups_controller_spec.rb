require "rails_helper"

RSpec.describe Education::Management::GroupsController, type: :controller do
  let!(:admin_edu){FactoryGirl.create :user, role: "admin"}
  let!(:user){FactoryGirl.create :user}

  describe "GET #index" do
    it "render index if sign in with admin_edu account" do
      sign_in admin_edu
      get :index
      expect(response).to render_template :index
    end

    it "render root if sign in with non_admin_edu account" do
      sign_in user
      get :index
      expect(response).to redirect_to education_root_url
    end
  end
end
