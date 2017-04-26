class CreateEducationSocials < ActiveRecord::Migration[5.0]
  def change
    create_table :education_socials do |t|
      t.string :name
      t.string :url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
