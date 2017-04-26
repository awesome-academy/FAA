require "rails_helper"

RSpec.describe Education::Management::LearningProgramsController,
  type: :controller do
  let!(:learning_program){FactoryGirl.create :learning_program}
  let!(:admin_edu){FactoryGirl.create :user}
  let!(:user){FactoryGirl.create :user}
  before do
    group = FactoryGirl.create(:education_group)
    FactoryGirl.create :education_user_group, user: admin_edu, group: group
    FactoryGirl.create :education_permission, group: group,
      entry: "Education::LearningProgram"
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

  describe "PATCH #update" do
    it "render root if sign in with non_admin_edu account" do
      sign_in user
      patch :update, params: {id: learning_program}
      expect(response).to redirect_to root_url
    end

    it "raise flash success if update successfully" do
      sign_in admin_edu
      patch :update, params: {id: learning_program, education_learning_program:
        FactoryGirl.attributes_for(:learning_program)}
      expect(controller).to set_flash[:success]
    end

    it "raise flash danger if update failed" do
      sign_in admin_edu
      patch :update, params: {id: learning_program,
        education_learning_program: FactoryGirl
          .attributes_for(:learning_program, name: nil)}
      expect(controller).to set_flash[:danger]
    end
  end
end
