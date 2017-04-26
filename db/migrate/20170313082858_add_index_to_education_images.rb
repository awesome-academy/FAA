class AddIndexToEducationImages < ActiveRecord::Migration[5.0]
  def change
    add_index :education_images, :imageable_id
    add_index :education_images, :imageable_type
  end
end
