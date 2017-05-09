class AddSomeColumsToEducationTrainings < ActiveRecord::Migration[5.0]
  def change
    add_column :education_trainings, :usage, :text
    add_column :education_trainings, :reason, :text
    add_column :education_trainings, :learner, :text
    add_column :education_trainings, :benefit, :text
    add_column :education_trainings, :duration, :integer
    add_column :education_trainings, :cost, :integer
  end
end
