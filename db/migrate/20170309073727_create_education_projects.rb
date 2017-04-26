class CreateEducationProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :education_projects do |t|
      t.string :name
      t.string :git_repo
      t.string :server_info
      t.string :pm_url
      t.boolean :is_project
      t.string :plat_form
      t.integer :comments_count, null: false, default: 0

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Education::Project.create_translation_table! description: :text,
          core_features: :text, release_note: :text
      end

      dir.down do
        Post.drop_translation_table!
      end
    end
  end
end
