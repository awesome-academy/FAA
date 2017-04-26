require "rails_helper"

RSpec.describe Education::CommentsController, type: :controller do
  let!(:user){FactoryGirl.create :user}
  let!(:project){FactoryGirl.create :project}
  describe "POST #create" do
     it "expect comment successful save" do
       expect do
         post :create,
           params: {project_id: project.id, education_comment: {user_id: user.id, content: "abc"}}, xhr: true end
           .to change(Education::Comment, :count).by(1)
           expect(assigns[:comment]).to be_an_instance_of Education::Comment
     end
   end

   it "content comment empty" do
     expect do
       post :create,
         params: {project_id: project.id, education_comment: {user_id: user.id, content: ""}}, xhr: true end
         .to change(Education::Comment, :count).by(0)
         expect(assigns[:comment]).to be_an_instance_of Education::Comment
    end
  describe "DELETE #destroy" do
    let!(:comment){FactoryGirl.create :comment, user_id: user.id, commentable_id: project.id, content: "ABC"}
    it "delete a comment successfully" do
      expect do
        delete :destroy, params: {id: comment.id, project_id: project.id}, xhr: true end
          .to change(Education::Comment, :count).by(-1)
    end

    it "delete a comment successfully" do
      allow_any_instance_of(Education::Comment).to receive(:destroy).and_return(false)
      expect do
        delete :destroy, params: {id: comment.id, project_id: project.id}, xhr: true end
            .to change(Education::Comment, :count).by(0)
    end
  end

  describe "GET #edit" do
  let!(:comment){FactoryGirl.create :comment, user_id: user.id, commentable_id: project.id, content: "ABC"}
   it do
      get :edit, params: {id: comment.id, project_id: project.id}, xhr: true
      expect(response).to render_template :edit
    end
  end

  describe "PUT #update" do
  let!(:comment){FactoryGirl.create :comment, user_id: user.id, commentable_id: project.id, content: "ABC"}
   it "action comment update state success" do
      put :update, params: {id: comment.id, project_id: project.id, education_comment: {content: "CAD"}}, xhr: true
      expect((Education::Comment.find(comment.id)).content).to eq "CAD"
    end
   it "action comment update state fail" do
      put :update, params: {id: comment.id, project_id: project.id, education_comment: {content: ""}}, xhr: true
      expect((Education::Comment.find(comment.id)).content).to eq "ABC"
    end
  end
end
