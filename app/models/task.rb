class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, length: { maximum: 300 }

  scope :title_search, -> (title){where("title LIKE ?", "%#{title}%")}
  scope :status_search, -> (status){where("status LIKE ?", "%#{status}%")}
  scope :order_created_desc, -> {order("created_at DESC")}

  enum priority: {高: 1, 中: 2, 低: 3}
end
