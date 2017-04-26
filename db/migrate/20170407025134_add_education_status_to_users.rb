class AddEducationStatusToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :education_status, :integer, default: 1
  end
end
