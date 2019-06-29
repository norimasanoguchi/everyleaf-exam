class Label < ApplicationRecord
  validates :label, presence: true, length: { maximum:50 }
  # has_many :tasks_labels, foreign_key: 'task_id', dependent: :destroy
  has_many :tasks_labels, dependent: :destroy
  has_many :tasks, through: :tasks_labels, source: :task
  accepts_nested_attributes_for :tasks_labels, allow_destroy: true
end
