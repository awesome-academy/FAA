namespace :db do
  desc "Seeding data"
  task edit_user: :environment do
    puts "Edit user"
    User.find_by(email: "pham.van.chien@framgia.com").update(name: "Pham Van Chien")
    User.find_by(email: "tran.duc.quoc@framgia.com").update(name: "Tran Duc Quoc")
    User.find_by(email: "hoang.thi.nhung@framgia.com").update(name: "Hoang Thi Nhung")
  end
end
