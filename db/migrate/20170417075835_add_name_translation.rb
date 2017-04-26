class AddNameTranslation < ActiveRecord::Migration[5.0]
  def change
    remove_column :education_learning_programs, :name
    reversible do |dir|
      dir.up do
        Education::LearningProgram.add_translation_fields! name: :text
      end

      dir.down do
        remove_column :education_learning_program_translations, :name
      end
    end
  end
end
