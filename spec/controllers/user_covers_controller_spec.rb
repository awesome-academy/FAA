require "rails_helper"

RSpec.describe UserCoversController, type: :controller do
  let!(:user){FactoryGirl.create :user}
  let!(:image) do
    Rack::Test::UploadedFile
      .new(Rails.root.join("spec", "support", "education", "image", "test.jpg"))
  end

  before do
    sign_in user
  end

  describe "POST #create" do
    it "change cover successfully" do
      post :create, params: {picture: image}
      expect(controller).to set_flash[:success]
        .to(I18n.t "user_covers.create.success")
    end

    it "change cover fail" do
      post :create, params: {picture: "file.jpg"}
      expect(controller).to set_flash[:danger]
        .to(I18n.t "user_covers.create.fail")
    end
  end

  describe "PATCH #update" do
    it "rails message if image not found in user's album" do
      patch :update, params: {image_id: nil}
      expect(controller).to set_flash[:danger]
        .to(I18n.t "user_covers.update.not_found")
    end

    it "update cover successfully" do
      cover = Image.create imageable: user, picture: image
      patch :update, params: {image_id: cover.id}
      expect(controller).to set_flash[:success]
        .to(I18n.t "user_covers.update.success")
    end
  end
end
