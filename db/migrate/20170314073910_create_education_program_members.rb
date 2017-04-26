class CreateEducationProgramMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :education_program_members do |t|
      t.references :user, foreign_key: true
      t.integer :learning_program_id

      t.timestamps
    end

    add_foreign_key :education_program_members, :education_learning_programs, column: :learning_program_id
  end
end
