namespace :education do
  desc "create posts for education"
  task make_posts: :environment do
    5.times do |i|
      post_params = {
        title: Faker::Lorem.sentence(3),
        content: Faker::Lorem.paragraph(100),
        user_id: User.first.id,
        category_id: rand(1..3),
        post_type: 0
      }
      post = Education::Post.create! post_params
    end

    5.times do |i|
      post_params = {
        title: Faker::Lorem.sentence(3),
        content: Faker::Lorem.paragraph(100),
        user_id: User.first.id,
        category_id: rand(4..5),
        post_type: 1
      }
      post = Education::Post.create! post_params
    end
  end
end
