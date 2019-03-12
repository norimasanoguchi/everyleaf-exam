class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, length: { maximum: 300 }
end
