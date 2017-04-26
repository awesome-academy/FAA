require "rails_helper"
require "support/controller_helpers"

RSpec.describe Education::TrainingsController, type: :controller do
  let(:training){FactoryGirl.create(:training)}
  let(:technique){FactoryGirl.create(:education_technique)}
  let(:technique1){FactoryGirl.create(:education_technique)}
  let(:technique2){FactoryGirl.create(:education_technique)}
  let(:params_true){FactoryGirl.attributes_for :training, name: "training",
   description: "description"}
  let(:params_fail){FactoryGirl.attributes_for :training, name: nil}
  let!(:user){FactoryGirl.create(:user)}
  before :each do
    FactoryGirl.create(:training_technique, training_id: training.id,
      technique_id: technique.id)
    group = FactoryGirl.create(:education_group)
    FactoryGirl.create :education_user_group, user: user, group: group
    FactoryGirl.create :education_permission, group: group,
      entry: "Education::Training"
    allow(controller).to receive(:current_user).and_return user
    sign_in user
  end

  describe "GET #index" do
    it do
      get :index
      expect(response).to have_http_status :success
    end

    context "get list training by filter technique" do
      it "result at least one object" do
        get :index, params: {technique_name: technique.name}
        expect(assigns(:training_object).trainings).to eq [training]
      end

      it "result is empty" do
        get :index, params: {technique_name: Faker::Name.first_name}
        expect(assigns(:training_object).trainings).to be_empty
      end
    end

    context "get training by name" do
      it "result at least one object" do
        get :index, params: {q: training.name}
        expect(assigns(:training_object).trainings).to eq [training]
      end
    end
  end

  describe "GET #new" do
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    it "create training successfully" do
      post :create, params: {education_training:
        FactoryGirl.attributes_for(:training, name: "abc"),
        technique_ids: [technique1.id, technique2.id]}
      expect(flash[:success]).not_to be_empty
    end

    it "create training fail" do
      post :create, params: {education_training:
        FactoryGirl.attributes_for(:training, name: nil),
        technique_ids: [technique1.id, technique2.id]}
      expect(flash[:danger]).not_to be_empty
      expect(response).to render_template :new
    end
  end

  describe "DELETE #destroy" do
    it "responds successfully" do
      delete :destroy, params: {id: training.id}, xhr: true
      expect{to change(Education::Training, :count).by(-1)}
    end
  end

  describe "PATCH #update" do
    it "update successfully" do
      patch :update, params: {id: training, education_training: params_true,
        technique_ids: [technique1.id, technique2.id]}
      expect(controller).to set_flash[:success]
    end

    it "update fail" do
      patch :update, params: {id: training, education_training: params_fail}
       expect(response).to render_template :edit
    end

    it "find training fail" do
      patch :update, params: {id: 100, training: params_true}
      expect(controller).to set_flash[:error]
      expect(response).to redirect_to education_root_path
    end
  end

   describe "GET #show" do
    before{get :show, params: {id: training}}

    context "load training success" do
      context "render the show template" do
        it{expect(subject).to respond_with 200}
        it do
          expect(subject).to render_with_layout "education/layouts/application"
        end
        it{expect(subject).to render_template :show}
      end

      context "assigns the requested training to @training" do
        it{expect(assigns(:training)).to eq training}
      end
    end

    context "cannot load training" do
      before do
        allow(Education::Training).to receive(:find_by).and_return(nil)
        get :show, params: {id: training}
      end

      it "redirect to education_root_path" do
        expect(response).to redirect_to education_root_path
      end

      it "get a flash error" do
        expect(flash[:error]).to eq I18n.t("education.trainings.training_not_found")
      end
    end
  end
end
