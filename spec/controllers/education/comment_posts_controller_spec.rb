require "rails_helper"

RSpec.describe Education::CommentPostsController, type: :controller do
  let!(:user){FactoryGirl.create :user}
  let!(:user2){FactoryGirl.create :user}
  let!(:education_post){FactoryGirl.create :education_post}
  let!(:comment){FactoryGirl.create :comment, user_id: user.id, commentable_id: education_post.id, content: "ABC"}
  let!(:comment2){FactoryGirl.create :comment, user_id: user2.id, commentable_id: education_post.id, content: "ABC"}

  before :each do
    allow(controller).to receive(:current_user).and_return(user)
    sign_in user
  end

  describe "POST #create" do
    it "expect comment successful save" do
      expect do
        post :create,
          params: {post_id: education_post.id, education_comment: {user_id: user.id, content: "abc"}}, xhr: true end
          .to change(Education::Comment, :count).by(1)
          expect(assigns[:comment]).to be_an_instance_of Education::Comment
    end
  end

  it "content comment empty" do
    expect do
      post :create,
        params: {post_id: education_post.id, education_comment: {user_id: user.id, content: ""}}, xhr: true end
        .to change(Education::Comment, :count).by(0)
        expect(assigns[:comment]).to be_an_instance_of Education::Comment
  end

  describe "DELETE #destroy" do
    it "delete a comment successfully" do
      expect do
          delete :destroy, params: {id: comment.id, post_id: education_post.id}, xhr: true end
            .to change(Education::Comment, :count).by(-1)
    end

    it "delete a comment unsuccessfully" do
      expect do
          delete :destroy, params: {id: comment2.id, post_id: education_post.id}, xhr: true end
            .to change(Education::Comment, :count).by(0)
    end
  end

  describe "GET #edit" do
    it do
      get :edit, params: {id: comment.id, post_id: education_post.id}, xhr: true
      expect(response).to render_template :edit
    end
  end

  describe "PUT #update" do
    it "action comment update state success" do
      put :update, params: {id: comment.id, post_id: education_post.id, education_comment: {content: "CAD"}}, xhr: true
      expect((Education::Comment.find(comment.id)).content).to eq "CAD"
    end

    it "action comment update state fail" do
      put :update, params: {id: comment.id, post_id: education_post.id, education_comment: {content: ""}}, xhr: true
      expect((Education::Comment.find(comment.id)).content).to eq "ABC"
    end
  end
end
