class CreateEducationPermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :education_permissions do |t|
      t.string :entry
      t.text :optional
      t.integer :group_id

      t.timestamps
    end

    add_foreign_key :education_permissions, :education_groups, column: :group_id
  end
end
