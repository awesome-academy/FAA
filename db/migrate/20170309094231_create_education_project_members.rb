class CreateEducationProjectMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :education_project_members do |t|
      t.integer :project_id
      t.references :user, foreign_key: true
      t.integer :position

      t.timestamps
    end

    add_foreign_key :education_project_members, :education_projects, column: :project_id
  end
end
