FactoryBot.define do
  factory :task, class: Task do
    title {'test_task_title'}
    content {'test_content_title'}
    expiration_at{''}
    status{''}
    id{''}
  end
end
