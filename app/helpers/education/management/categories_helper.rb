module Education::Management::CategoriesHelper
  def category_type_select
    Education::Category.category_types.map{|category, index| [category, index]}
  end
end
