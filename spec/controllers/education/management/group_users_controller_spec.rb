require "rails_helper"

RSpec.describe Education::Management::GroupUsersController, type: :controller do
  let!(:admin_edu){FactoryGirl.create :user}
  let!(:user){FactoryGirl.create :user}
  let!(:group){FactoryGirl.create(:education_group)}
  before do
    FactoryGirl.create :education_user_group, user: admin_edu, group: group
    FactoryGirl.create :education_permission, group: group,
      entry: "Education::UserGroup"
  end

  describe "GET #index" do
    it "render index if sign in with admin_edu account" do
      sign_in admin_edu
      get :index
      expect(response).to render_template :index
    end

    it "render root if sign in with non_admin_edu account" do
      sign_out admin_edu
      sign_in user
      get :index
      expect(response).to redirect_to root_url
    end
  end

  describe "POST #create" do
    context "not logged in user" do
      before{sign_out admin_edu}
      it "can not change group" do
        expect do
          post :create,
            params: {
              "education_management_users":
                "{\"users\":
                  [{\"id\":\"#{user.id}\"}],
                \"group\":\"#{group.id}\"}"
            },
            xhr: true
        end
          .to change(user.education_groups, :count).by 0
      end
    end

    context "change group success" do
      before{sign_in admin_edu}
      it "can not change group" do
        expect do
          post :create,
            params: {
              "education_management_users":
                "{\"users\":
                  [{\"id\":\"#{user.id}\"}],
                \"group\":\"#{group.id}\"}"
            },
            xhr: true
        end
          .to change(user.education_groups, :count).by 1
      end
    end
  end

  describe "DELETE #destroy" do
    context "not logged in user" do
      before{sign_out admin_edu}
      it "can not remove user from group" do
        expect do
          delete :destroy,
            params: {
              "education_management_users":
                "{\"users\":
                  [{\"id\":\"#{user.id}\"}],
                \"group\":\"#{group.id}\"}"
            },
            xhr: true
        end
          .to change(user.education_groups, :count).by 0
      end
    end

    context "change group success" do
      before{sign_in admin_edu}
      before{user.education_groups << group}
      it "remove user from group successful" do
        expect do
          delete :destroy,
            params: {
              "education_management_users":
                "{\"users\":
                  [{\"id\":\"#{user.id}\"}],
                \"group\":\"#{group.id}\"}"
            },
            xhr: true
        end
          .to change(user.education_groups, :count).by -1
      end
    end
  end
end
