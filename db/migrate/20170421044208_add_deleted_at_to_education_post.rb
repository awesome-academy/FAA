class AddDeletedAtToEducationPost < ActiveRecord::Migration[5.0]
  def change
    add_column :education_posts, :deleted_at, :datetime
    add_index :education_posts, :deleted_at
  end
end
