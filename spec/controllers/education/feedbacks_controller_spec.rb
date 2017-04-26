require "rails_helper"

RSpec.describe Education::FeedbacksController, type: :controller do
  let(:education_feedback){FactoryGirl.create :education_feedback}

  describe "GET #new" do
    before{get :new}
    context "render the show template" do
      it do
        expect(response).to be_success
      end
      it do
        expect(response).to render_with_layout "education/layouts/application"
      end
      it do
        expect(response).to render_template :new
      end
    end
  end

  describe "POST #create with successfully saved" do
    before do
      post :create, params: {education_feedback:
        FactoryGirl.attributes_for(:education_feedback)}
    end
    it do
      is_expected.to set_flash[:success]
        .to(I18n.t("education.feedback.feedback_success"))
    end

    it do
      is_expected.to redirect_to education_root_path
    end
  end

  describe "POST #create with fail saved" do
    before do
      allow_any_instance_of(Education::Feedback).to receive(:save)
      .and_return(false)
      post :create, params: {education_feedback:
        FactoryGirl.attributes_for(:education_feedback)}
    end
    it do
      is_expected.to set_flash[:danger]
        .to(I18n.t("education.feedback.feedback_error"))
    end

    it{is_expected.to render_template :new}
  end
end
