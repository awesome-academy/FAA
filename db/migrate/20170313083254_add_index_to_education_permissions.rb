class AddIndexToEducationPermissions < ActiveRecord::Migration[5.0]
  def change
    add_index :education_permissions, :group_id
  end
end
