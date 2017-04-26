class CreateEducationComments < ActiveRecord::Migration[5.0]
  def change
    create_table :education_comments do |t|
      t.references :user, foreign_key: true
      t.integer :commentable_id
      t.string :commentable_type
      t.text :content

      t.timestamps
    end

    # add_foreign_key :education_comments, :education_projects, column: :commentable_id
    # add_foreign_key :education_comments, :education_posts, column: :commentable_id
  end
end
