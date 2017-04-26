namespace :education do
  desc "create posts for education"
  task make_posts: :environment do
    10.times do |i|
      post_params = {
        title: Faker::Lorem.sentence(3),
        content: Faker::Lorem.paragraph(100),
        user_id: User.first.id,
        category_id: Education::Category.first.id
      }

      post = Education::Post.create! post_params
    end
  end
end
