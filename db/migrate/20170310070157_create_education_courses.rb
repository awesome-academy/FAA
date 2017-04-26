class CreateEducationCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :education_courses do |t|
      t.string :name
      # t.text :detail
      t.integer :training_id
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end

    add_foreign_key :education_courses, :education_trainings, column: :training_id

    reversible do |dir|
      dir.up do
        Education::Course.create_translation_table! detail: :text
      end

      dir.down do
        Education::Course.drop_translation_table!
      end
    end
  end
end
