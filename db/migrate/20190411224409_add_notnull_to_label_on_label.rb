class AddNotnullToLabelOnLabel < ActiveRecord::Migration[5.2]
  def change
    def up
      change_column(:labels, :label, :string, null: false)
    end

    def down
      change_column(:labels, :label, :string)
    end
  end
end
