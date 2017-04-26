require "rails_helper"

RSpec.describe Education::ImagesController, type: :controller do
  let!(:education_image){FactoryGirl.create(:education_image)}
  let!(:user){FactoryGirl.create(:user)}

  describe "POST #create" do
    before{allow(controller).to receive(:current_user).and_return user}
    context "create valid image" do
      it "save success" do
        expect do
          post :create, params: {file: education_image.url}, xhr: true
        end
        .to change(Education::Image, :count).by 1
      end
    end

    context "create invalid image" do
      it "save failed" do
        allow_any_instance_of(Education::Image).to receive(:save)
          .and_return false
        expect do
          post :create, params: {file: education_image.url}, xhr: true
        end
        .to change(Education::Image, :count).by 0
      end
    end
  end
end
