require "rails_helper"

RSpec.describe Education::Management::TechniquesController, type: :controller do
  let(:technique){FactoryGirl.create(:education_technique)}
  let!(:user){FactoryGirl.create(:user)}
  before :each do
    group = FactoryGirl.create(:education_group)
    FactoryGirl.create :education_user_group, user: user, group: group
    FactoryGirl.create :education_permission, group: group,
      entry: "Education::Technique"
    allow(controller).to receive(:current_user).and_return user
    sign_in user
  end

  describe "GET #index" do
    before{get :index}

    context "render the show template" do
      it{expect(subject).to respond_with 200}
      it do
        expect(subject)
          .to render_with_layout "education/layouts/application_management"
      end
      it{expect(subject).to render_template :index}
    end

    context "populates an array of techniques" do
      it{expect(assigns(:techniques)).to eq [technique]}
    end
  end

  describe "GET #new" do
    it "renders the :new template" do
      get :new, xhr: true
      expect(response).to render_template partial: "_form"
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "save new technique to database" do
        expect do
          post :create, params:
            {education_technique: FactoryGirl
              .attributes_for(:education_technique)}
        end.to change(Education::Technique, :count).by 1
      end

      it "redirects to technique index page" do
        post :create, params:
          {education_technique: FactoryGirl
            .attributes_for(:education_technique)}
        expect(response).to redirect_to education_management_techniques_path
      end
    end

    context "with invalid attributes" do
      it "does not save invalid technique to database" do
        expect do
          post :create, params:
            {education_technique: FactoryGirl
              .attributes_for(:invalid_technique)}
        end.not_to change(Education::Technique, :count)
      end
      it "show flash error" do
        post :create, params:
          {education_technique: FactoryGirl.attributes_for(:invalid_technique)}
        expect(flash[:danger])
          .to eq I18n.t("education.techniques.create.new_faild")
      end
    end
  end

  describe "PATCH #update" do
    let(:technique){FactoryGirl.create :education_technique, name: "Old Name"}

    context "with valid attributes" do
      it "update technique attributes" do
        patch :update, params: {id: technique, education_technique:
          FactoryGirl.attributes_for(:education_technique, name: "New Name")}
        technique.reload
        expect(technique.name).to eq "New Name"
      end

      it "redirects to technique index page" do
        patch :update, params: {id: technique, education_technique:
          FactoryGirl.attributes_for(:education_technique)}
        expect(response).to redirect_to education_management_techniques_path
      end
    end

    context "with invalid attributes" do
      it "does not update invalid technique" do
        patch :update, params: {id: technique, education_technique:
          FactoryGirl.attributes_for(:education_technique, name: "")}
        technique.reload
        expect(technique.name).not_to eq "New Name"
      end

      it "show flash error" do
        patch :update, params: {id: technique,
          education_technique: FactoryGirl.attributes_for(:invalid_technique)}
        expect(flash[:danger])
          .to eq I18n.t("education.techniques.update.update_fail")
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:technique){FactoryGirl.create :education_technique}
    it "deletes the technique" do
      expect{delete :destroy, params: {id: technique}}
        .to change(Education::Technique, :count).by -1
    end

    it "redirects to education root path" do
      delete :destroy, params: {id: technique}
      expect(response).to redirect_to education_techniques_path
    end
  end
end
