class AddDeletedAtToTranings < ActiveRecord::Migration[5.0]
  def change
    add_column :education_trainings, :deleted_at, :datetime
    add_index :education_trainings, :deleted_at
  end
end
