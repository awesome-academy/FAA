class CreateEducationAbouts < ActiveRecord::Migration[5.0]
  def change
    create_table :education_abouts do |t|
      # t.string :title
      # t.text :content

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Education::About.create_translation_table! title: :string, content: :text
      end

      dir.down do
        Education::About.drop_translation_table!
      end
    end
  end
end
