class CreateInfoUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :info_users do |t|
      t.integer :relationship_status
      t.text :introduce
      t.string :quote
      t.string :ambition
      t.references :user, index: true, unique: true, foreign_key: true

      t.timestamps
    end
  end
end
