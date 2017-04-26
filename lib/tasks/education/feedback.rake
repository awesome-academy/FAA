namespace :education do
  desc "create feedback for education"
  task make_feedbacks: :environment do
    90.times do |i|
      feedback_params = {
        name: Faker::Name.name,
        email: "example-#{i + 1}@gmail.com",
        subject: Faker::Lorem.sentence,
        content: Faker::Lorem.sentence,
        phone_number: "1234567890#{i + 1}",
      }
      feedback = Education::Feedback.create! feedback_params
    end
  end
end
