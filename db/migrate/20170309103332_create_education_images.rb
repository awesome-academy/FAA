class CreateEducationImages < ActiveRecord::Migration[5.0]
  def change
    create_table :education_images do |t|
      t.string :url
      t.integer :imageable_id
      t.string :imageable_type

      t.timestamps
    end
  end
end
