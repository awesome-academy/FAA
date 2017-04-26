require "rails_helper"

RSpec.describe Education::ProjectMembersController, type: :controller do

  let!(:project){FactoryGirl.create(:project)}
  let!(:user1){FactoryGirl.create(:user)}
  let!(:user2){FactoryGirl.create(:user)}
  let!(:user3){FactoryGirl.create(:user)}
  let!(:project_member){FactoryGirl.
    create(:project_member, project_id: project.id, user_id: user1.id)}
  let!(:user){FactoryGirl.create(:user)}
  before :each do
    group = FactoryGirl.create(:education_group)
    FactoryGirl.create :education_user_group, user: user, group: group
    FactoryGirl.create :education_permission, group: group,
      entry: "Education::ProjectMember"
    allow(controller).to receive(:current_user).and_return user
    sign_in user
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "save new project member to database" do
        expect{
          post :create, xhr: true,
            params: {users: {user2.id => 1, user3.id => 1}, project_id: project.id}
        }.to change(Education::ProjectMember, :count).by 2
      end

    end

    context "with invalid attributes" do
      it "donot save project member to database" do
        expect{
          post :create, params: {users: [user1.id, -1], project_id: project.id},
            xhr: true
        }.to raise_error(ActiveRecord::ActiveRecordError)
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the project member" do
      expect{
        delete :destroy, xhr: true,
          params: {id: project_member.id, user_id: user1.id, project_id: project.id}
      }.to change(Education::ProjectMember, :count).by -1
    end
  end

  context "cannot load project" do
    before do
      allow(Education::Project).to receive(:find_by).and_return(nil)
      delete :destroy, xhr: true,
        params: {id: project_member.id, user_id: user1.id, project_id: project.id}
    end
    it "get a flash error" do
      expect(flash[:danger]).to be_present
    end
  end

  context "cannot load project member" do
    before do
      delete :destroy, xhr: true,
        params: {id: project_member.id, user_id: -1, project_id: project.id}
    end
    it "get a flash error" do
      expect(flash[:danger]).to be_present
    end
  end
end
