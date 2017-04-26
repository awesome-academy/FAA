require "ffaker"

namespace :db do
  desc "Seeding data"
  task seeding: :environment do
    %w[db:drop db:create db:migrate db:seed].each do |task|
      Rake::Task[task].invoke
    end

    puts "Create users"
    users = {
      "hoang.thi.nhung@framgia.com": "Hoang Thi Nhung",
      "do.ha.long@framgia.com": "Do Ha Long",
      "do.van.nam@framgia.com": "Do Van Nam",
      "nguyen.ha.phan@framgia.com": "Nguyen Ha Phan",
      "luu.thi.thom@framgia.com": "Luu Thi Thom",
      "thuy.viet.quoc@framgia.com": "Thuy Viet Quoc",
      "tran.anh.vu@fsramgia.com": "Tran Anh Vu",
      "le.quang.canh@sframgia.com": "Le Quang Anh",
      "nguyen.ngoc.thinh@framgia.com": "Nguyen Ngoc Thinh",
      "tran.xuan.nam@framgia.com": "Tran Xuan Nam",
      "user@gmail.com": "User",
      "ttkt1994@gmail.com": "User"
    }

    users.each do |email, name|
      user = User.create! name: name, email: email, password:
        123456, education_status: rand(0..1)
      InfoUser.create! user_id: user.id, introduce: Faker::Lorem.paragraph
    end

    edu_admin = User.create! name: "Education admin",
      password: "123456",
      education_status: 1,
      email: "admin.education@framgia.com"
    InfoUser.create! user_id: edu_admin.id, introduce: Faker::Lorem.paragraph

    user = User.create! name: "Adminprp",
      email: "admin@gmail.com",
      password: "123456",
      role: 1
    InfoUser.create! user_id: user.id, introduce: Faker::Lorem.paragraph

    puts "Create Education informations"
    Rake::Task["education:education_seeding"].invoke

  end
end
