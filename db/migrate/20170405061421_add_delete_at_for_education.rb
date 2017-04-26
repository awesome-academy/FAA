class AddDeleteAtForEducation < ActiveRecord::Migration[5.0]
  def change
    add_column :education_projects, :deleted_at, :datetime
    add_index :education_projects, :deleted_at

    add_column :education_project_techniques, :deleted_at, :datetime
    add_index :education_project_techniques, :deleted_at

    add_column :education_training_techniques, :deleted_at, :datetime
    add_index :education_training_techniques, :deleted_at

    add_column :education_techniques, :deleted_at, :datetime
    add_index :education_techniques, :deleted_at
  end
end
