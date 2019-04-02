class RemoveEpireatcolomunToTasksAgain < ActiveRecord::Migration[5.2]
  def change
    remove_column(:tasks, :expire_at, :date)
    add_column(:tasks, :expiration_at, :date)
  end
end
