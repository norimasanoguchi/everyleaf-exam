require 'rails_helper'

RSpec.feature "ラベルづけ機能のテスト", type: :feature  do

  feature "ラベル作成と投稿のテスト" do
    background do
      FactoryBot.create(:user, name: 'test01', email: 'test01@test.com',admin: true, password: 'password')
      FactoryBot.create(:label, label: 'test_test_label', id: 99)
      visit new_session_path
      fill_in 'Email', with: 'test01@test.com'
      fill_in 'Password', with: 'password'
      click_on '保存する'
    end

    scenario "ラベル作成のテスト" do
      visit new_admin_label_path
      fill_in 'Label', with: 'test_label'
      visit admin_labels_path
      expect(page).to have_content('test_label')
    end

    scenario "タスク投稿時ラベル付けおよび詳細画面でのラベル表示のテスト" do
      visit new_task_path
      fill_in 'タイトル', with: 'test_labeled_task'
      fill_in '内容', with: 'test_labeled_task_content'
      # check 'test_test_label', id:"task_label_ids_99"
      # check 'test_test_label', name:"task[label_ids][]"
      # find(:label,'test_test_label').click
      find('#task_label_ids_99').click
      click_on '登録する'
      click_link '詳細', id:"test_labeled_task"
      expect(page).to have_content('test_test_label')
    end

    scenario "ラベルで検索できるかテスト" do
      visit new_task_path
      fill_in 'タイトル', with: 'test_labeled_task'
      fill_in '内容', with: 'test_labeled_task_content'
      # check 'test_test_label', id:"task_label_ids_99"
      find('#task_label_ids_99').click
      click_on '登録する'
      select 'test_test_label', from: 'ラベルで検索'
      click_on '検索する'
      task_titles = page.all('.task_title').map(&:text)
      expect(task_titles).to eq(['test_labeled_task'])
    end
  end
end
