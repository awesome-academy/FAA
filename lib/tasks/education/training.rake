namespace :education do
  desc "create trainings & courses for education"
  task make_trainings: :environment do

    30.times do |n|
      training_params = {
        name: "Training #{n}",
        description: FFaker::Lorem.paragraph
      }

      training = Education::Training.create! training_params
      4.times do |n|
        training.training_techniques.create technique_id: n + 1
      end
      
      5.times do |i|
        course_params = {
          name: Faker::Name.name,
          detail: FFaker::Lorem.sentence,
          training_id: n+1,
          start_date: FFaker::Time.date,
          end_date: FFaker::Time.date,
          status: 0
        }
        course = Education::Course.create! course_params
        course.images.create url: "/default.jpg"
        4.times do |t|
          course.course_members.create(user_id: (t+1))
        end
      end
    end
  end
end
