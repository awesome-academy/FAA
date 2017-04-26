require "rails_helper"

RSpec.describe Education::Management::PermissionsController,
  type: :controller do
  let!(:admin_edu){FactoryGirl.create :user}
  let!(:user){FactoryGirl.create :user}
  before do
    group = FactoryGirl.create(:education_group)
    FactoryGirl.create :education_user_group, user: admin_edu, group: group
    FactoryGirl.create :education_permission, group: group,
      entry: "Education::Permission"
    sign_in admin_edu
  end

  describe "POST #create" do
    it "render root if sign in with non_admin_edu account" do
      sign_in user
      post :create
      expect(response).to redirect_to root_url
    end

    it "return json with success flash if successful update" do
      permission_id = Education::Permission.first.id
      post :create, params: {permissions: "{\"#{permission_id}\":
        {\"create\":true,\"read\":true,\"update\":true,\"destroy\":false}}"},
        format: :json
      expected =
        {flash: I18n.t("education.management.permissions.create.success"),
        status: 200}.to_json
      expect(response.body).to eq expected
    end

    it "return json with flash fail if permission not found" do
      post :create, params: {permissions: "{\"0\":
        {\"create\":true,\"read\":true,\"update\":true,\"destroy\":false}}"},
        format: :json
      expected =
        {flash: I18n.t("education.management.permissions.create.not_found"),
        status: 400}.to_json
      expect(response.body).to eq expected
    end
  end
end
