require 'rails_helper'

RSpec.describe 'AdminArticlesEmbeddedMedia', type: :system do
  let(:admin) {create :user, :admin }
  let!(:article) {create :article}

  describe '記事の埋め込みブロックを追加' do
    before do
      login(admin)
      visit edit_admin_article_path(article.uuid)
      click_on 'ブロックを追加する'
      click_on '埋め込み'
      click_on '編集'
    end

    it 'YouTubeを選択しアップロード' do
      select 'YouTube', from: '埋め込みタイプ'
      fill_in 'ID', with: 'https://youtu.be/h-zamTxwAzU'
      first('.box-footer').click_on '更新する'
      click_on('プレビュー')
      switch_to_window(windows.last)
      expect(current_path).to eq(admin_article_preview_path(article.uuid))
    end
    it 'Twitterを選択しアップロード' do
      select 'Twitter', from: '埋め込みタイプ'
      fill_in 'ID', with: 'https://twitter.com/NOqvWY0hJfCNdaB/status/1444559371380297730?ref_src=twsrc%5Etfw'
      first('.box-footer').click_on '更新する'
      sleep 1
      click_on('プレビュー')
      switch_to_window(windows.last)
      expect(current_path).to eq(admin_article_preview_path(article.uuid))
      sleep 2
      expect(page).to have_selector(".twitter-tweet")
    end
  end
end
