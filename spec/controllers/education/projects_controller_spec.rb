require "rails_helper"
require "support/controller_helpers"

RSpec.describe Education::ProjectsController, type: :controller do
  let(:project){FactoryGirl.create(:project)}
  let(:technique){FactoryGirl.create(:education_technique)}
  let(:technique1){FactoryGirl.create(:education_technique)}
  let(:technique2){FactoryGirl.create(:education_technique)}
  let!(:user){FactoryGirl.create(:user)}
  before :each do
    FactoryGirl.create :project_technique, project_id: project.id,
      technique_id: technique.id
    group = FactoryGirl.create(:education_group)
    FactoryGirl.create :education_user_group, user: user, group: group
    FactoryGirl.create :education_permission, group: group,
      entry: "Education::Project"
    allow(controller).to receive(:current_user).and_return user
    sign_in user
  end

  describe "GET #index" do
    before{get :index}

    context "render the show template" do
      it{expect(subject).to respond_with 200}
      it do
        expect(subject).to render_with_layout "education/layouts/application"
      end
      it{expect(subject).to render_template :index}
    end

    context "populates an array of projects" do
      it{expect(assigns(:projects)).to eq [project]}
    end

    context "get project with filter technique" do
      it "result at least one object" do
        get :index, params: {technique_name: technique.name}
        expect(assigns(:projects)).to eq [project]
      end

      it "result is empty" do
        get :index, params: {technique_name: Faker::Name.first_name}
        expect(assigns(:projects)).to be_empty
      end
    end

    context "search project with name" do
      it "result at least one object" do
        get :index, params: {term: project.name}
        expect(assigns(:projects)).to eq [project]
      end

      it "result is empty" do
        get :index, params: {term: Faker::Name.first_name}
        expect(assigns(:projects)).to be_empty
      end
    end
  end

  describe "GET #show" do
    before{get :show, params: {id: project}}

    context "load project success" do
      context "render the show template" do
        it{expect(subject).to respond_with 200}
        it do
          expect(subject).to render_with_layout "education/layouts/application"
        end
        it{expect(subject).to render_template :show}
      end

      context "assigns the requested project to @project" do
        it{expect(assigns(:project)).to eq project}
      end
    end

    context "cannot load project" do
      before do
        allow(Education::Project).to receive(:find_by).and_return(nil)
        get :show, params: {id: project}
      end

      it "redirect to education_root_path" do
        expect(response).to redirect_to education_root_path
      end

      it "get a flash error" do
        expect(flash[:danger]).to eq(
          I18n.t("education.projects.project_not_found"))
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
    context "with valid attributes" do
      it "save new project to database" do
        expect{
          post :create, xhr: true, params:
            {education_project: FactoryGirl.attributes_for(:project),
              technique_ids: [technique1.id, technique2.id]}
        }.to change(Education::Project, :count).by 1
      end
    end

    context "with invalid attributes" do
      it "does not save invalid project to database" do
        expect{
          post :create, xhr: true, params:
            {education_project: FactoryGirl.attributes_for(:invalid_project)}
        }.not_to change(Education::Project, :count)
      end

      it "re-renders :new template" do
        post :create, params:
          {education_project: FactoryGirl.attributes_for(:invalid_project)}
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    let(:project) {FactoryGirl.create :project, name: "Old Name",
      server_info: "Server info"}

    context "with valid attributes" do
      it "update project attributes" do
        patch :update, xhr: true, params: {id: project, education_project:
          FactoryGirl.attributes_for(:project, name: "New Name"),
          technique_ids: [technique1.id, technique2.id]}
        project.reload
        expect(project.name).to eq "New Name"
      end
    end

    context "with invalid attributes" do
      it "does not update invalid project" do
        patch :update, params: {id: project, education_project:
          FactoryGirl.attributes_for(:project, name: "New Name",
            server_info: nil)}
        project.reload
        expect(project.name).not_to eq "New Name"
        expect(project.server_info).to eq "Server info"
      end

      it "re-renders :edit template" do
        patch :update, params: {id: project,
          education_project: FactoryGirl.attributes_for(:invalid_project)}
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:project) {FactoryGirl.create :project}
    it "responds successfully" do
      delete :destroy, params: {id: project.id}, xhr: true
      expect{to change(Education::Project, :count).by(-1)}
    end
  end
end
