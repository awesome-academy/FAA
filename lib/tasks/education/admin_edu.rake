namespace :db do
  desc "Seeding data"
  task admin_edu: :environment do
    puts "Create education group of user"
    Education::UserGroup.destroy_all
    admin_edu = User.find_by email: "admin.education@framgia.com"
    Education::UserGroup.create user_id: 1, group_id: 2
    Education::UserGroup.create user_id: 3, group_id: 2
    Education::UserGroup.create user_id: 4, group_id: 2
    Education::UserGroup.create user_id: 5, group_id: 2
    Education::UserGroup.create user_id: 2, group_id: 3
    Education::UserGroup.create user_id: admin_edu.id, group_id: 1
  end
end
