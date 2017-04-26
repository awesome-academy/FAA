class CreateEducationProjectTechniques < ActiveRecord::Migration[5.0]
  def change
    create_table :education_project_techniques do |t|
      t.integer :project_id
      t.integer :technique_id

      t.timestamps
    end

    add_foreign_key :education_project_techniques, :education_projects, column: :project_id
    add_foreign_key :education_project_techniques, :education_techniques, column: :technique_id
  end
end
