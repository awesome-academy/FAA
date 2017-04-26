class CreateEducationTrainingTechniques < ActiveRecord::Migration[5.0]
  def change
    create_table :education_training_techniques do |t|
      t.integer :training_id
      t.integer :technique_id

      t.timestamps
    end

    add_foreign_key :education_training_techniques, :education_trainings, column: :training_id
    add_foreign_key :education_training_techniques, :education_techniques, column: :technique_id
  end
end
