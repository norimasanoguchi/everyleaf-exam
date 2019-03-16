require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  scenario "タスク一覧のテスト" do
    Task.create!(title: 'test_task_01',content: 'testtesttest')
    Task.create!(title: 'test_task_02',content: 'samplesample')

   visit tasks_path

   expect(page).to have_content 'testtesttest'
   expect(page).to have_content 'samplesample'

  end

  scenario "タスク作成のテスト" do
    visit new_task_path
    fill_in 'Title', with: 'test_title'
    fill_in 'Content', with: 'test_content'
    click_on 'Create Task'

    visit tasks_path
    expect(page).to have_content('test_title')
  end

  scenario "タスク詳細のテスト" do
    test_task = FactoryBot.create(:task)
    visit task_path(test_task)
    expect(page).to have_content('test_task_title','test_content_title')
  end

end
