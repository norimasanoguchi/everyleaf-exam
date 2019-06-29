class RemoveLabelColumnFromTasks < ActiveRecord::Migration[5.2]
  def change
    remove_column(:tasks, :label, :string)
  end
end
