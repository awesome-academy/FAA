class AddCategoryTypeToEducationCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :education_categories, :category_type, :integer, default: 0
  end
end
