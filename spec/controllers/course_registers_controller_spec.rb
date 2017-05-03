require "rails_helper"

RSpec.describe CourseRegistersController, type: :controller do
  let!(:course){FactoryGirl.create :course}
  let!(:course_register){FactoryGirl.create :course_register}

  describe "POST #create" do
    context "valid register" do
      it do
        expect do
          post :create, params: {
            course_register: FactoryGirl.attributes_for(:course_register)
          }, xhr: true
        end
          .to change(CourseRegister, :count).by 1
      end
      it do
        post :create, params: {
          course_register: FactoryGirl.attributes_for(:course_register)
        }, xhr: true
        expect(flash[:success])
          .to eq I18n.t "course_registers.create.create_success"
      end
    end

    context "invalid register" do
      it do
        expect do
          post :create, params: {
            course_register: FactoryGirl
              .attributes_for(:course_register, name: "")
          }, xhr: true
        end
          .to change(CourseRegister, :count).by 0
      end
      it do
        post :create, params: {
          course_register: FactoryGirl
            .attributes_for(:course_register, name: "")
        }, xhr: true
        expect(flash[:danger])
          .to eq I18n.t "course_registers.create.create_failed"
      end
    end
  end
end
