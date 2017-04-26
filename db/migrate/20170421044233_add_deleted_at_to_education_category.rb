class AddDeletedAtToEducationCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :education_categories, :deleted_at, :datetime
    add_index :education_categories, :deleted_at
  end
end
