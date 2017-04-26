class AddIndexToImages < ActiveRecord::Migration[5.0]
  def change
    add_index :images, :imageable_id
    add_index :images, :imageable_type
  end
end
