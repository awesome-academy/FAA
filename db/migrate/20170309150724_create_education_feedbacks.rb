class CreateEducationFeedbacks < ActiveRecord::Migration[5.0]
  def change
    create_table :education_feedbacks do |t|
      t.string :name
      t.string :email
      t.text :content
      t.string :phone_number
      t.string :subject

      t.timestamps
    end
  end
end
