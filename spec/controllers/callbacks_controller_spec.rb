require "rails_helper"

RSpec.describe CallbacksController, type: :controller do
  let!(:user){FactoryGirl.create :user}
  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:hr_system]
  end

  describe "POST #create" do
    context "when authentication success" do
      it "should successfully create a user" do
        expect{post :hr_system}.to change(User, :count).by 1
      end
    end
    context "when create user failed" do
      before do
        allow(User)
          .to receive(:from_omniauth).and_return User.new
        post :hr_system
      end
      it "should redirect to root path" do
        expect(controller).to redirect_to root_path
      end
      it "should set flash[:notice]" do
        expect(flash[:notice])
          .to eq I18n.t ".callbacks.hr_system.auth_failure"
      end
    end
  end
end
