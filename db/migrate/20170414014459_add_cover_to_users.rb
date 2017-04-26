class AddCoverToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :cover_image_id, :integer
    remove_column :users, :avatar
    add_column :users, :avatar_id, :integer
  end
end
