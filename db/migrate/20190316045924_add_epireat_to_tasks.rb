class AddEpireatToTasks < ActiveRecord::Migration[5.2]
  def change
      add_column(:tasks, :expiration_at, :datetime, :null => false, default: -> { 'NOW()+7days' })
  end
end
