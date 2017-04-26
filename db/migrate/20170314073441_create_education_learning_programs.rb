class CreateEducationLearningPrograms < ActiveRecord::Migration[5.0]
  def change
    create_table :education_learning_programs do |t|
      t.string :name
      # t.text :description

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Education::LearningProgram.create_translation_table! description: :text
      end

      dir.down do
        Education::LearningProgram.drop_translation_table!
      end
    end
  end
end
