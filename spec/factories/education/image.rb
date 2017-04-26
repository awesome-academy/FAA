FactoryGirl.define do
  factory :education_image, class: Education::Image do
    url do
      Rack::Test::UploadedFile.new(
        Rails.root.join("spec", "support", "education", "image", "test.jpg")
      )
    end
  end
end
