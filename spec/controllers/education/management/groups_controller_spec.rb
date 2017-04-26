require "rails_helper"

RSpec.describe Education::Management::GroupsController, type: :controller do
  let!(:admin_edu){FactoryGirl.create :user}
  let!(:user){FactoryGirl.create :user}
  before do
    group = FactoryGirl.create(:education_group)
    FactoryGirl.create :education_user_group, user: admin_edu, group: group
    FactoryGirl.create :education_permission, group: group,
      entry: "Education::Group"
  end

  describe "GET #index" do
    it "render index if sign in with admin_edu account" do
      sign_in admin_edu
      get :index
      expect(response).to render_template :index
    end

    it "render root if sign in with non_admin_edu account" do
      sign_in user
      get :index
      expect(response).to redirect_to root_url
    end
  end
end
