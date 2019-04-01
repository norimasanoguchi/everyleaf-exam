require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do

  feature "タスクをあらかじめ作成するタスク" do
    background do
      FactoryBot.create(:task, title: 'test_task_01',content: 'testtesttest',expiration_at: '2019_03_03_051550', status: '未着手')
      FactoryBot.create(:task, title: 'test_task_02',content: 'samplesample',expiration_at: '2019_02_02_051550', status: '着手中')
      FactoryBot.create(:task, title: 'test_task_03',content: 'samplesample',expiration_at: '2019_01_01_051550', status: '完了')
    end

    scenario "タスク一覧のテスト" do
     visit tasks_path
     expect(page).to have_content 'testtesttest'
     expect(page).to have_content 'samplesample'
    end

    scenario "タスク一覧が作成日順に並んでいるかテスト" do
      visit tasks_path
      task_titles = page.all('.task_title').map(&:text)
      expect(task_titles[0]).to eq('test_task_03')
      expect(task_titles[1]).to eq('test_task_02')
      expect(task_titles[2]).to eq('test_task_01')
    end

    scenario "タスク一覧が作成日順に降順並んでいるかテスト" do
      visit tasks_path
      click_on '終了期限でソートする'
      task_titles = page.all('.task_title').map(&:text)
      expect(task_titles[0]).to eq('test_task_01')
      expect(task_titles[1]).to eq('test_task_02')
      expect(task_titles[2]).to eq('test_task_03')
    end
   end

  feature "検索機能のテスト" do
    background do
      FactoryBot.create(:task, title: 'test01', content: 'test01', status: '未着手', id: '1')
      FactoryBot.create(:task, title: 'test01' ,content: 'test01', status: '着手中', id: '2')
      FactoryBot.create(:task, title: 'test02' ,content: 'test01', status: '着手中', id: '3')
      FactoryBot.create(:task, title: 'test03' ,content: 'test01', status: '未着手', id: '4')
    end

    scenario "タイトルとステータスで検索できるかテスト" do
      visit tasks_path
      fill_in 'タイトルで検索する', with: 'test01'
      select '未着手', from: 'ステータスで検索する'
      click_on '検索する'
      task_titles = page.all('.task_title').map(&:text)
      expect(task_titles).to eq(['test01'])
    end

    scenario "タイトルで検索できるかテスト" do
      visit tasks_path
      fill_in 'タイトルで検索する', with: 'test'
      select '着手中', from: 'ステータスで検索する'
      click_on '検索する'
      task_titles = page.all('.task_title').map(&:text)
      expect(task_titles).to eq(['test01','test02'])
    end

    scenario "タイトルで検索できるかテスト" do
      visit tasks_path
      fill_in 'タイトルで検索する', with: ''
      select '未着手', from: 'ステータスで検索する'
      click_on '検索する'
      task_titles = page.all('.task_title').map(&:text)
      expect(task_titles).to eq(['test01','test03'])
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

  feature "バリデーション関連のテスト" do

    scenario "titleが空ならバリデーションが通らない" do
      test_task = FactoryBot.build(:task, title: '',content: 'testtesttest' )
      test_task.valid?
      expect(test_task.errors[:title]).to include("を入力してください")
    end

    scenario "contentが空ならバリデーションが通らない" do
      test_task = FactoryBot.build(:task, title: 'testtest',content: '' )
      test_task.valid?
      expect(test_task.errors[:content]).to include("を入力してください")
    end

    scenario "titleとcontentに内容が記載されていればバリデーションが通る" do
      test_task = FactoryBot.create(:task, title: 'testtest',content: 'testtesttest' )
      test_task.valid?
      expect(test_task).to be_valid
    end
  end

end
