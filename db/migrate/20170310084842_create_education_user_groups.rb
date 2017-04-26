class CreateEducationUserGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :education_user_groups do |t|
      t.references :user, foreign_key: true
      t.integer :group_id
      t.boolean :is_default_group

      t.timestamps
    end

    add_foreign_key :education_user_groups, :education_groups, column: :group_id
  end
end
