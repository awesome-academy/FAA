class CreateUserCertificates < ActiveRecord::Migration[5.0]
  def change
    create_table :user_certificates do |t|
      t.references :user, foreign_key: true
      t.references :certificate, foreign_key: true

      t.timestamps
    end
  end
end
