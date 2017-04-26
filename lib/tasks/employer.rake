require "ffaker"

namespace :db do
  desc "Seeding data"
  task employer: :environment do
    if Rails.env.production?
      puts "Do not running in 'Production' task"
    else
      puts "Create positions"
      positions = ["Manager", "Director", "Admin"]
      positions.each do |position|
        Position.create! name: position, company_id: 1
      end

      puts "Create groups"
      groups = ["Education", "HR", "BO"]
      groups.each do |group|
        Group.create! name: group, company_id: rand(1..2),
          description: FFaker::Lorem.sentence
      end

      puts "Create user groups"
      UserGroup.create! user_id: 12, position_id: 3, group_id: 2,
        is_default_group: true

      puts "Create company permission"
      models = ["Company", "Job", "Candidate", "TeamIntroduction"]
      models.each do |model|
        Permission.create! entry: model, group_id: 2,
          optional: {create: true, read: true, update: true, destroy: true}
      end

      puts "Create admin of company"
      UserGroup.create! user_id: 1, position_id: 3, group_id: 2,
        is_default_group: true
    end
  end
end
