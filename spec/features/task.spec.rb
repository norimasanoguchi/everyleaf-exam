require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  # let(:tasks) { page.all('.task_title') }

  feature "タスクをあらかじめ作成するタスク" do
    background do
      FactoryBot.create(:task, title: 'test_task_01',content: 'testtesttest' )
      FactoryBot.create(:task, title: 'test_task_02',content: 'samplesample')
    end

    scenario "タスク一覧のテスト" do
     visit tasks_path
     expect(page).to have_content 'testtesttest'
     expect(page).to have_content 'samplesample'
    end

    scenario "タスク一覧が作成日順に並んでいるかテスト" do
      visit tasks_path
      task_titles = page.all('.task_title').map(&:text)
      expect(task_titles[0]).to eq('test_task_02')
      expect(task_titles[1]).to eq('test_task_01')
    end

   end

  scenario "タスク作成のテスト" do
    visit new_task_path
    fill_in 'タイトル', with: 'test_title'
    fill_in '内容', with: 'test_content'
    click_on '登録する'

    visit tasks_path
    expect(page).to have_content('test_title')
  end

  scenario "タスク詳細のテスト" do
    test_task = FactoryBot.create(:task)
    visit task_path(test_task)
    expect(page).to have_content('test_task_title','test_content_title')
  end

end
