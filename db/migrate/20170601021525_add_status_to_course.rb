class AddStatusToCourse < ActiveRecord::Migration[5.0]
  def change
    add_column :education_courses, :status, :integer   
  end
end
