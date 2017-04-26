require "rails_helper"

RSpec.describe Education::CourseMembersController, type: :controller do

  let!(:course){FactoryGirl.create(:course)}
  let!(:user1){FactoryGirl.create(:user)}
  let!(:user2){FactoryGirl.create(:user)}
  let!(:course_member){FactoryGirl.
    create(:course_member, course_id: course.id, user_id: user1.id)}
  let!(:user){FactoryGirl.create(:user)}
  before :each do
    group = FactoryGirl.create(:education_group)
    FactoryGirl.create :education_user_group, user: user, group: group
    FactoryGirl.create :education_permission, group: group,
      entry: "Education::CourseMember"
    allow(controller).to receive(:current_user).and_return user
    sign_in user
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "save new course member to database" do
        expect{
          post :create, xhr: true,
            params: {users: [user1.id, user2.id], course_id: course.id}
        }.to change(Education::CourseMember, :count).by 2
      end

    end

    context "with invalid attributes" do
      it "donot save course member to database" do
        expect{
          post :create, params: {users: [user1.id, -1], course_id: course.id},
            xhr: true
        }.to raise_error(ActiveRecord::ActiveRecordError)
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the course member" do
      expect{
        delete :destroy, xhr: true,
          params: {id: course_member.id, user_id: user1.id, course_id: course.id}
      }.to change(Education::CourseMember, :count).by -1
    end
  end

  context "cannot load course" do
    before do
      allow(Education::Course).to receive(:find_by).and_return(nil)
      delete :destroy, xhr: true,
        params: {id: course_member.id, user_id: user1.id, course_id: course.id}
    end
    it "get a flash error" do
      expect(flash[:danger]).to eq I18n.t("education.courses.not_found")
    end
  end

  context "cannot load course member" do
    before do
      delete :destroy, xhr: true,
        params: {id: course_member.id, user_id: -1, course_id: course.id}
    end
    it "get a flash error" do
      expect(flash[:danger]).to eq I18n.t("education.course_members.not_found")
    end
  end
end
