class CreateEducationTechniques < ActiveRecord::Migration[5.0]
  def change
    create_table :education_techniques do |t|
      t.string :name

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Education::Technique.create_translation_table! description: :text
      end

      dir.down do
        Education::Technique.drop_translation_table!
      end
    end
  end
end
