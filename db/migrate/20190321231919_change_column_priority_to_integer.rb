class ChangeColumnPriorityToInteger < ActiveRecord::Migration[5.2]
  def change
    def up
      change_column(:tasks, :priority, 'integer USING CAST(priority AS integer)')
    end

    def down
      change_column(:tasks, :priority, :string)
    end
  end
end
