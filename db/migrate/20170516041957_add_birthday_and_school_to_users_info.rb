class AddBirthdayAndSchoolToUsersInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :info_users, :birthday, :date
    add_column :info_users, :school, :string
  end
end
