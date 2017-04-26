class CreateEducationCourseMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :education_course_members do |t|
      t.references :user, foreign_key: true
      t.integer :course_id
      t.integer :status

      t.timestamps
    end
    add_foreign_key :education_course_members, :education_courses, column: :course_id
  end
end
