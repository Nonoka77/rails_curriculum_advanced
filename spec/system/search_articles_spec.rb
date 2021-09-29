require 'rails_helper'

RSpec.describe 'SearchArticles', type: :system do
  let(:admin) { create :user, :admin }
  let!(:article) {create :article}
  let!(:article_tag) { create :tag }
  let!(:sentence) { create :sentence }

  before do
    login(admin)
    visit admin_articles_path
  end

  describe '記事一覧ページ' do
    it 'カテゴリー検索したとき' do
      within('.box-tools') do
        select "応用課題1", from: 'q[category_id]'
      end
      expect(page).to have_content("応用課題1")
    end
    it '著者を検索したとき' do
      within('.box-tools') do
        select (article.author.name), from: 'q[author_id]'
      end
        expect(page).to have_content(article.author.name)
    end
    it 'タグを検索したとき' do
      within('.box-tools') do
        select (article_tag.name), from: 'q[tag_id]'
      end
        expect(page).to have_content(article_tag.name)
    end
    it 'タイトルを検索したとき' do
      within('.box-tools') do
        fill_in 'タイトル', with: article.title
      end
        expect(page).to have_content(article.title)
    end
    xit '本文を検索したとき' do
      within('.box-tools') do
        fill_in '本文', with: 'body'
      end
        click_on 'プレビュー'
        switch_to_window windows.last
        expect(page).to include('body')
    end

  end
end
