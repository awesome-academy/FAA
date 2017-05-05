require "rails_helper"

RSpec.describe CourseRegister, type: :model do
  describe "associations" do
    it{is_expected.to belong_to :education_course}
  end

  describe "validations" do
    it{is_expected.to validate_presence_of :name}
    it do
      is_expected.to validate_length_of(:name)
        .is_at_most Settings.course_register.max_name_length
    end
    it do
      is_expected.to validate_length_of(:name)
        .is_at_least Settings.course_register.min_name_length
    end
    it{is_expected.to validate_presence_of :email}
    it do
      is_expected.to validate_length_of(:email)
        .is_at_most Settings.course_register.max_email_length
    end
    it do
      is_expected.to validate_length_of(:phone_number)
        .is_at_most Settings.course_register.max_phone_number_length
    end
    it do
      is_expected.to validate_length_of(:phone_number)
        .is_at_least Settings.course_register.min_phone_number_length
    end
    it do
      is_expected.to validate_length_of(:address)
        .is_at_most Settings.course_register.max_address_length
    end
    it do
      is_expected.to validate_length_of(:address)
        .is_at_least Settings.course_register.min_address_length
    end
  end
end
