require "rails_helper"

RSpec.describe Education::Management::CategoriesController, type: :controller do
  let!(:admin_edu){FactoryGirl.create :user}
  let!(:user){FactoryGirl.create :user}
  let!(:category){FactoryGirl.create :education_category}
  before do
    group = FactoryGirl.create(:education_group)
    FactoryGirl.create :education_user_group, user: admin_edu, group: group
    FactoryGirl.create :education_permission, group: group,
      entry: "Education::Category"
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

  describe "POST #create" do
    it "render root if sign in with non_admin_edu account" do
      sign_in user
      post :create, params: {education_category: {name: "Ruby on Rails"}}
      expect(response).to redirect_to root_url
    end

    it "create new category successfully" do
      sign_in admin_edu
      post :create, params: {education_category: {name: "Ruby on Rails"}}
      expect(controller).to set_flash[:success]
        .to(I18n.t "education.management.categories.create.success")
    end

    it "create new category fail if name nil" do
      sign_in admin_edu
      post :create, params: {education_category: {name: nil}}
      expect(controller).to set_flash[:danger]
        .to(I18n.t "education.management.categories.create.fail")
    end
  end

  describe "PATCH #update" do
    it "render root if sign in with non_admin_edu account" do
      sign_in user
      patch :update, params: {id: category}
      expect(response).to redirect_to root_url
    end

    it "render json success if update category successfully" do
      sign_in admin_edu
      patch :update, params: {id: category,
        education_category: {name: "Ruby on Rails"}}, xhr: true
      expected = {flash:
        I18n.t("education.management.categories.update.success"),
        status: 200, name: "Ruby on Rails"}.to_json
      expect(response.body).to eq expected
    end

    it "render json fail if update category failed" do
      sign_in admin_edu
      patch :update, params: {id: category,
        education_category: {name: nil}}, xhr: true
      expected = {flash:
        I18n.t("education.management.categories.update.fail"),
        status: 400, name: nil}.to_json
      expect(response.body).to eq expected
    end
  end

  describe "DELETE #destroy" do
    it "render root if sign in with non_admin_edu account" do
      sign_in user
      delete :destroy, params: {id: category}
      expect(response).to redirect_to root_url
    end

    it "render json success if destroy category successfully" do
      sign_in admin_edu
      delete :destroy, params: {id: category}, xhr: true
      expected = {flash:
        I18n.t("education.management.categories.destroy.success"),
        status: 200, name: nil}.to_json
      expect(response.body).to eq expected
    end
  end
end
