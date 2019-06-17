class Task < ApplicationRecord
  belongs_to :user
  # has_many :tasks_labels, foreign_key: 'task_id', dependent: :destroy
  has_many :tasks_labels, dependent: :destroy
  has_many :labels, through: :tasks_labels, source: :label
  accepts_nested_attributes_for :tasks_labels, allow_destroy: true

  validates :title, presence: true
  validates :content, presence: true, length: { maximum: 300 }

  scope :title_search, -> (title){where("title LIKE ?", "%#{title}%")}
  scope :status_search, -> (status){where("status LIKE ?", "%#{status}%")}
  scope :task_id_search, -> (task_ids){where(id: task_ids)}
  scope :order_created_desc, -> {order("created_at DESC")}

  enum priority: {高: 1, 中: 2, 低: 3}
end
