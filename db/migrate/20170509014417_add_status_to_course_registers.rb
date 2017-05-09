class AddStatusToCourseRegisters < ActiveRecord::Migration[5.0]
  def change
    add_column :course_registers, :status, :integer, default: 1
  end
end
