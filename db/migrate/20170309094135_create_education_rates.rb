class CreateEducationRates < ActiveRecord::Migration[5.0]
  def change
    create_table :education_rates do |t|
      t.float :rate, default: 0
      t.references :user, foreign_key: true
      t.integer :rateable_id
      t.string :rateable_type

      t.timestamps
    end
  end
end
