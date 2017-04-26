class CreateEducationPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :education_posts do |t|
      # t.string :title
      t.text :content
      t.integer :category_id
      t.references :user, foreign_key: true
      t.string :cover_photo
      t.string :tags
      t.integer :comments_count, null: false, default: 0
      t.timestamps
    end

    add_foreign_key :education_posts, :education_categories, column: :category_id

    reversible do |dir|
      dir.up do
        Education::Post.create_translation_table! title: :string
      end

      dir.down do
        Education::Post.drop_translation_table!
      end
    end
  end
end
