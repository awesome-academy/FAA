require "ffaker"

namespace :education do
  desc "Seeding course registers"
  task course_register: :environment do
    if Rails.env.production?
      puts "Do not running in 'Production' task"
    else
      Education::Course.all.each do |course|
        course_register = course.course_registers.build name: FFaker::Name.name,
          email: FFaker::Internet.email, phone_number: FFaker::PhoneNumber.phone_number,
          address: FFaker::Address.street_address
        course_register.save!
      end
    end
  end
end
