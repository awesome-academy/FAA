require "rails_helper"
require "support/controller_helpers"

RSpec.describe Education::PostsController, type: :controller do
  let(:education_post){FactoryGirl.create :education_post}
  let(:new_education_post){FactoryGirl.create :new_education_post}
  let(:params_valid){FactoryGirl.attributes_for :education_post,
    title: "Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem."}
  let(:params_invalid){FactoryGirl.attributes_for :education_post,
    title: nil}
  let!(:category){FactoryGirl.create :education_category}
  let!(:user){FactoryGirl.create :user}
  let!(:another_user){FactoryGirl.create :user}

  before :each do
    allow(controller).to receive(:current_user).and_return(user)
    sign_in user
  end

  describe "GET #index" do
    it do
      get :index
      expect(response).to have_http_status :success
    end
  end

  describe "GET #show" do
    before{get:show, params: {id: education_post}}
    context "load project success" do
      context "render show template" do

        it{expect(subject).to respond_with 200}

        it do
          expect(subject)
            .to render_with_layout "education/layouts/application"
        end

        it{expect(subject).to render_template :show}
      end

      context "assigns the requested post to @post" do
         it{expect(assigns(:post)).to eq education_post}
      end
    end

    context "load post failed" do
      before do
        allow(Education::Post).to receive(:find_by).and_return(nil)
        get :show, params: {id: education_post}
      end

      it "redirect to education_posts_path" do
        expect(response).to redirect_to education_posts_path
      end

      it "get a flash error" do
        expect(flash[:danger]).to eq(
          I18n.t("education.post.post_not_found"))
      end
    end
  end

  describe "GET #new" do
    context "logged in user" do
      it "render new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    context "not logged in user" do
      before{sign_out user}

      it "render divise login" do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "POST #create" do
    context "not logged in user" do
      before{sign_out user}

      it "can not destroy" do
        expect do
          post :create, params: {education_post: FactoryGirl.attributes_for(:education_post, category_id: category.id)}, xhr: true
        end
        .to change(Education::Post, :count).by 0
      end
    end

    context "create valid post" do
      let(:tag){FactoryGirl.create :tag}
      it "save success" do
        expect do
          post :create, params: {education_post: FactoryGirl.attributes_for(:education_post, category_id: category.id)}, xhr: true
        end
        .to change(Education::Post, :count).by 1
      end

      it "save success and save a new tag" do
        expect do
          post :create, params: {education_post: FactoryGirl.attributes_for(:education_post, category_id: category.id, tags: tag)}, xhr: true
        end
        .to change(Tag, :count).by 1
      end
    end

    context "create valid post" do
      it "save success" do
        expect do
          post :create, params: {education_post: FactoryGirl.attributes_for(:education_post, category_id: nil)}, xhr: true
        end
        .to change(Education::Post, :count).by 0
        expect(response).to render_template :new
      end
    end
  end

  describe "DELETE #destroy" do

    context "not logged in user" do
      before{sign_out user}
      let!(:education_post){FactoryGirl.create :education_post, user: user}

      it "delete fail" do
        expect{
          delete :destroy, params: {id: education_post}, format: :js
        }.to change(Education::Post, :count).by 0
      end
    end

    context "post doesn't belongs to user" do
      let!(:education_post){FactoryGirl.create :education_post, user: another_user}

      it "delete_fail" do
        expect{
          delete :destroy, params: {id: education_post}, format: :js
        }.to change(Education::Post, :count).by 0
      end
    end

    context "post belongs to user" do
      let!(:education_post){FactoryGirl.create :education_post, user: user}

      it "delete success" do
        expect{
          delete :destroy, params: {id: education_post}, format: :js
        }.to change(Education::Post, :count).by -1
      end
    end

    context "post belongs to user but delete fail" do
      let!(:education_post){FactoryGirl.create :education_post, user: user}

      it "set flash" do
        allow_any_instance_of(Education::Post).to receive(:destroy)
          .and_return(false)
        delete :destroy, params: {id: education_post}, format: :js
        expect(flash[:danger])
          .to eq I18n.t "education.posts.destroy.post_delete_fail"
      end
    end
  end

  describe "GET #edit" do
    context "not logged in user" do
      before{sign_out user}

      it "redirect to login page" do
        get :edit, params: {id: education_post}
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "logged in user" do
      let!(:education_post){FactoryGirl.create :education_post, user: user}

      it "render edit template" do
        get :edit, params: {id: education_post}
        expect(response).to render_template :edit
      end
    end
  end

  describe "PATCH #update" do

    context "not logged in user" do
      before{ patch :update, params: {id: education_post, education_post: params_valid}}
      before{sign_out user}

      it "can not update post" do
        expect(education_post.title).not_to eq "Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem."
      end
    end

    context "user logged in but post doesn't belong to user" do
      before{ patch :update, params: {id: education_post, education_post: params_valid}}
      let!(:education_post){FactoryGirl.create :education_post, user: another_user}

      it "can not update post" do
        expect(education_post.title).not_to eq "Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem."
      end
    end

    context "with valid attributes" do
      let!(:education_post){FactoryGirl.create :education_post, user: user}
      before{patch :update, params: {id: education_post, education_post: params_valid}}

      it "update project attributes" do
        education_post.reload
        expect(education_post.title)
          .to eq "Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem."
      end

      it "redirects to post detail page" do
        expect(response).to redirect_to education_post
      end
    end

    context "with invalid attributes" do
      let!(:education_post){FactoryGirl.create :education_post, user: user}
      before{patch :update, params: {id: education_post, education_post: params_invalid}}

      it "does not update invalid post" do
        education_post.reload
        expect(education_post.title)
          .not_to eq "Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem."
      end

      it "re-renders :edit template" do
        patch :update, params: {id: education_post,
          education_post: FactoryGirl.attributes_for(:invalid_education_post)}
        expect(response).to render_template :edit
      end
    end
  end
end
