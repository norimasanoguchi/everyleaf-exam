class TasksLabel < ApplicationRecord
  belongs_to :task
  belongs_to :label

  scope :label_id_search, -> (label_ids){where(label_id: label_ids)}
end
