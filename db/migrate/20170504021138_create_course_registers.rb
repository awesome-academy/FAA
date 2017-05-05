class CreateCourseRegisters < ActiveRecord::Migration[5.0]
  def change
    create_table :course_registers do |t|
      t.integer :course_id, foreign_key: true
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :address

      t.timestamps
    end

    add_foreign_key :course_registers, :education_courses, column: :course_id
  end
end
