require "rails_helper"

RSpec.describe Education::Management::UsersController, type: :controller do
  let!(:admin_edu){FactoryGirl.create :user}
  let!(:user){FactoryGirl.create :user}
  before do
    group = FactoryGirl.create(:education_group)
    FactoryGirl.create :education_user_group, user: admin_edu, group: group
    FactoryGirl.create :education_permission, group: group,
      entry: "User"
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

  describe "PATCH #update" do
    it "render root if sign in with non_admin_edu account" do
      sign_in user
      patch :update, params: {id: user}
      expect(response).to redirect_to root_url
    end

    it "return json success if update user status successfully" do
      sign_in admin_edu
      patch :update, params: {id: user, user: FactoryGirl.attributes_for(:user,
        education_status: "active")}, xhr: true
      expected = {flash: I18n.t("education.management.users.update.success"),
        status: 200}.to_json
      expect(response.body).to eq expected
    end

    it "return json fail if update user status failed" do
      sign_in admin_edu
      patch :update, params: {id: user, user:
        FactoryGirl.attributes_for(:user, education_status: nil)}, xhr: true
      expected = {flash: I18n.t("education.management.users.update.fail"),
        status: 400}.to_json
      expect(response.body).to eq expected
    end
  end
end
