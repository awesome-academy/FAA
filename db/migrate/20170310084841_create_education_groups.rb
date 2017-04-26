class CreateEducationGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :education_groups do |t|
      t.string :name
      # t.text :description

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Education::Group.create_translation_table! description: :text
      end

      dir.down do
        Education::Group.drop_translation_table!
      end
    end
  end
end
