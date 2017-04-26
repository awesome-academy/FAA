require "rails_helper"

RSpec.describe Education::RatesController, type: :controller do
  let!(:user){FactoryGirl.create :user}
  let!(:education_post){FactoryGirl.create :education_post}
  let(:project){FactoryGirl.create(:project)}
  let!(:rate){FactoryGirl.create :rate, user_id: user.id,
    rateable_id: education_post.id, rate: 3.0,
    rateable_type: Education::Rate.name}

  before :each do
    allow(controller).to receive(:current_user).and_return(user)
    sign_in user
  end

  describe "POST #create" do
    context "rate successful" do
      it "rate post successful" do
        expect do
        post :create, params:
          {education_rate: {user_id: user.id,rate: 3.5,
            rateable_type: Education::Post.name},
            post_id: education_post.id}, xhr: true
        end
        .to change(Education::Rate, :count).by 1
      end

      it "rate project successful" do
        expect do
        post :create, params:
          {education_rate: {user_id: user.id, rate: 3.5,
            rateable_type: Education::Project.name}, project_id: project.id},
            xhr: true
        end
        .to change(Education::Rate, :count).by 1
      end
    end

    context "rate unsuccessful" do
      it "can not rate post when user not login" do
        sign_out user
        expect do
        post :create, params:
          {education_rate: {user_id: user.id, rate: 3.5,
            rateable_type: Education::Post.name},
            post_id: education_post.id}, xhr: true
        end
        .to change(Education::Rate, :count).by 0
      end

      it "can not rate project when user not login" do
        sign_out user
        expect do
        post :create, params:
          {education_rate: {user_id: user.id, rate: 3.5,
            rateable_type: Education::Project.name}, project_id: project.id},
            xhr: true
        end
        .to change(Education::Rate, :count).by 0
      end

      it "can not rate post with blank rate param" do
        expect do
        post :create, params:
          {education_rate: {user_id: user.id, rate: "",
            rateable_type: Education::Post.name}, post_id: education_post.id},
            xhr: true
        end
        .to change(Education::Rate, :count).by 0
      end

      it "can not rate project with blank rate param" do
        expect do
        post :create, params:
          {education_rate: {user_id: user.id, rate: "",
            rateable_type: Education::Project.name}, project_id: project.id},
            xhr: true
        end
        .to change(Education::Rate, :count).by 0
      end
    end
  end
end
