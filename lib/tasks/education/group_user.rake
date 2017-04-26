namespace :db do
  desc "Seeding data"
  task group_user: :environment do
    Education::Permission.create entry: "User", group_id: 1,
      optional: {create: true, read: true, update: true, destroy: true}
  end
end
