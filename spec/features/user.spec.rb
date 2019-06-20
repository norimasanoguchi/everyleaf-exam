require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do

  scenario "ユーザー登録時に同時ログイン（マイページ表示）" do
    visit new_user_path
    fill_in '名前', with: 'test99'
    fill_in 'メールアドレス', with: 'test99@test.com'
    fill_in 'パスワード', with: 'password'
    fill_in '確認用パスワード', with: 'password'
    click_on '登録する'
    expect(page).to have_content('test99@test.com')
  end

  scenario "ログインアウト時indexページいくとログインページ遷移" do
    visit tasks_path
    expect(page).to have_content('ログイン')
  end

  feature "ユーザーログイン時のテスト" do
    background do
      @user01 = FactoryBot.create(:user, name: 'test01', email: 'test01@test.com', id: '1', password: 'password')
      @user02 = FactoryBot.create(:user, name: 'test02', email: 'test02@test.com', id: '2', password: 'password')
      @task01 = FactoryBot.create(:task, title: 'task_for_User01', user_id: @user01.id)
      @task02 = FactoryBot.create(:task, title: 'task_for_User02', user_id: @user02.id)
      visit new_session_path
      fill_in 'Email', with: 'test01@test.com'
      fill_in 'Password', with: 'password'
      click_on '保存する'
    end

    scenario "自分が作成したタスクだけ表示" do
      visit tasks_path
      expect(page).to have_content('task_for_User01')
      expect(page).not_to have_content('task_for_User02')
    end

    scenario "ログイン時はユーザー登録画面いかない" do
      visit new_user_path
      expect(page).not_to have_content('ユーザー登録')
    end

    scenario "ログインユーザーでないユーザーのマイページ行かない" do
      visit user_path(@task02.id)
      expect(page).to have_content('ユーザーが異なります。詳細ページを見るにはログインしなおしてください')
    end
  end
end
