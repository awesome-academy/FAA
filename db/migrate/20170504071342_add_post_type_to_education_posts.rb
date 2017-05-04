class AddPostTypeToEducationPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :education_posts, :post_type, :integer
  end
end
