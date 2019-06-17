class AddNotnullToLabelOnLabelAgain < ActiveRecord::Migration[5.2]
    def change
      change_column_null :labels, :label, false
    end
end
