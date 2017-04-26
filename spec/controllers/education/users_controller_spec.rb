require "rails_helper"

RSpec.describe Education::UsersController, type: :controller do
  let(:user){FactoryGirl.create :user}

  describe "GET #show" do
    before{get :show, params: {id: user}}

    context "load user success" do
      context "render the user template" do
        it{expect(subject).to respond_with 200}
        it do
          expect(subject).to render_with_layout "education/layouts/application"
        end
        it{expect(subject).to render_template :show}
      end

      context "assigns the requested project to @user" do
        it{expect(assigns :user).to eq user}
      end
    end

    context "load blocked user" do
      let(:user){FactoryGirl.create :user, education_status: 0}
      before do
        get :show, params: {id: user}
      end
      it{expect(response).to redirect_to root_path}
    end
  end
end
