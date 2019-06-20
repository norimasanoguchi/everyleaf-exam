require 'rails_helper'

RSpec.feature "管理機能のテスト", type: :feature  do

  feature "管理ユーザーログイン時のテスト" do
    background do
      FactoryBot.create(:user, name: 'test01', email: 'test01@test.com',admin: true, password: 'password')
      FactoryBot.create(:user, name: 'test02', email: 'test02@test.com',admin: true, password: 'password')
      visit new_session_path
      fill_in 'Email', with: 'test01@test.com'
      fill_in 'Password', with: 'password'
      click_on '保存する'
    end

    scenario "ユーザー一覧のテスト" do
      visit admin_users_path
      expect(page).to have_content('test01','test01@test.com')
      expect(page).not_to have_content('test03','test03@test.com')
    end

    scenario "ユーザー作成のテスト" do
      visit new_admin_user_path
      fill_in '名前', with: 'test04'
      fill_in 'メールアドレス', with: 'test04@test.com'
      check 'Admin'
      fill_in 'パスワード', with: 'password'
      fill_in '確認用パスワード', with: 'password'
      click_on '登録する'
      expect(page).to have_content('test04','test04@test.com')
    end

    scenario "ユーザー詳細のテスト" do
      user = User.find_by(name: 'test02')
      visit admin_users_path
      click_link '詳細', href:admin_user_path(user)
      expect(page).to have_content('test02','test02@test.com')
    end

    scenario "ユーザー更新のテスト" do
      user = User.find_by(name: 'test02')
      visit admin_users_path
      click_link '編集', href:edit_admin_user_path(user)
      fill_in '名前', with: 'test99'
      fill_in 'メールアドレス', with: 'test99@test.com'
      check 'Admin'
      fill_in 'パスワード', with: 'password'
      fill_in '確認用パスワード', with: 'password'
      click_on '登録する'
      expect(page).to have_content('test99','test99@test.com')

    end

    scenario "ユーザー削除のテスト" do
      user = User.find_by(name: 'test02')
      visit admin_users_path
      click_link '削除', href:admin_user_path(user)
      expect(page).to have_content('ユーザーtest02を削除しました')
    end

  end
end
