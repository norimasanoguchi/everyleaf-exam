require 'rails_helper'

RSpec.feature "タスク検索機能", type: :model do
  background do
    FactoryBot.create(:task, title: 'test01', content: 'test01', status: '未着手', id: '1')
    FactoryBot.create(:task, title: 'test01' ,content: 'test01', status: '着手中', id: '2')
    FactoryBot.create(:task, title: 'test02' ,content: 'test01', status: '着手中', id: '3')
    FactoryBot.create(:task, title: 'test03' ,content: 'test01', status: '完了', id: '4')
    @tasks = Task.all
  end


  scenario "タイトルとステータスで検索" do
    expect(@tasks.title_search("test01").status_search("未着手").ids).to eq [1]
  end

  scenario "タイトルのみで検索" do
    expect(@tasks.title_search("test01").ids).to eq [1,2]
  end

  scenario "ステータスのみで検索" do
    expect(@tasks.status_search("着手中").ids).to eq [2,3]
  end
end
