class AddEpireatcolomunToTasksAgain < ActiveRecord::Migration[5.2]
  def change
    add_column(:tasks, :expire_at, :date)
  end
end
