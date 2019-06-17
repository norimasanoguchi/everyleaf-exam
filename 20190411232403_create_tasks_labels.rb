class CreateTasksLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks_labels do |t|
      t.integer :label_id
      t.integer :task_id
      t.timestamps
    end
  end
end
