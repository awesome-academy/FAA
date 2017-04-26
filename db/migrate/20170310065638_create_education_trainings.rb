class CreateEducationTrainings < ActiveRecord::Migration[5.0]
  def change
    create_table :education_trainings do |t|
      t.string :name

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Education::Training.create_translation_table! description: :text
      end

      dir.down do
        Education::Training.drop_translation_table!
      end
    end
  end
end
