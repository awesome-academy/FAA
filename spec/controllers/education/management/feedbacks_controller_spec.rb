require "rails_helper"

RSpec.describe Education::Management::FeedbacksController, type: :controller do
  let!(:feedback){FactoryGirl.create :education_feedback}
  let!(:admin_edu){FactoryGirl.create :user}
  let!(:user){FactoryGirl.create :user}
  before do
    group = FactoryGirl.create(:education_group)
    FactoryGirl.create :education_user_group, user: admin_edu, group: group
    FactoryGirl.create :education_permission, group: group,
      entry: "Education::Feedback"
    sign_in admin_edu
  end

  describe "GET #index" do
    it "render index if sign in with admin_edu account" do
      get :index
      expect(response).to render_template :index
    end

    it "render root if sign in with non_admin_edu account" do
      sign_in user
      get :index
      expect(response).to redirect_to root_url
    end
  end

  describe "DELETE #destroy" do
    context "cannot load feedback" do
      before do
        allow(Education::Feedback).to receive(:find_by).and_return(nil)
        delete :destroy, params: {id: feedback.id}, xhr: true
      end
      it "get a flash error" do
        expect(flash[:error]).to be_present
      end
    end

    it "destroy successfully" do
      delete :destroy, params: {id: feedback.id}, xhr: true, format: :json
      expect(response.body).to eq({flash:
        I18n.t("education.management.feedbacks.destroy.deleted_success"),
        status: 200}.to_json)
      expect{to change(Education::Feedback, :count).by(-1)}
    end

    context "post belongs to user but delete fail" do
      it "delete fail" do
        delete :destroy, params: {id: feedback.id}, xhr: true
        expect{to change(Education::Feedback, :count).by 0}
      end

      it "set flash when delete fail" do
        allow_any_instance_of(Education::Feedback).to receive(:destroy)
          .and_return(false)
        delete :destroy, params: {id: feedback.id}
        expect(flash[:danger]).to be_present
      end
    end
  end
end
