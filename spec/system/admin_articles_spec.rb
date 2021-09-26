require 'rails_helper'

RSpec.describe 'AdminArticles', type: :system do
  let(:admin) {create(:user, :admin)}
  let(:draft_article) {create(:article, :draft)}
  let(:past_article) {create(:article, :published)}
  let(:future_article) {create(:article, :publish_wait)}
  before do
    login(admin)
  end
  describe '記事編集画面から「更新する」を押したときステータスが「下書き状態以外」' do
    context '公開日が未来の場合' do
      it 'ステータスを「公開待ち」に変更して「更新しました」とフラッシュメッセージを表示' do
        visit edit_admin_article_path(future_article.uuid)
        click_on '更新する'
        expect(page).to have_content('更新しました')
      end
    end
    context '公開日時が「現在または過去の日付」に設定された場合' do
      it 'ステータスを「公開」に変更して「更新しました」とフラッシュメッセージを表示' do
      visit edit_admin_article_path(past_article.uuid)
      click_on '更新する'
      expect(page).to have_content('更新しました')
      end
    end
  end

  describe '記事編集画面から「更新する」を押した際に、ステータスが「下書き状態」の場合' do
    it 'ステータスは「下書き」のまま「更新しました」とフラッシュメッセージを表示' do
      visit edit_admin_article_path(draft_article.uuid)
      click_on '更新する'
      expect(page).to have_content('更新しました')
    end
  end

  describe '記事編集画面から「公開する」を押した場合' do
    context '「公開日時が未来の日付の記事」に「公開する」を押した場合' do
      it 'ステータスを「公開待ち」に変更して「記事を公開待ちにしました」とフラッシュメッセージを表示' do
        visit edit_admin_article_path(future_article.uuid)
        click_on '公開する'
        expect(page).to have_content('公開待ちにしました')
        expect(page).to have_select('状態', selected: '公開待ち')
      end
    end
    context '「公開日時が過去の日付の記事」に「公開する」を押した場合' do
      it 'ステータスを「公開」に変更して「記事を公開しました」とフラッシュメッセージを表示' do
        visit edit_admin_article_path(past_article.uuid)
        click_on '公開する'
        expect(page).to have_content('公開しました')
        expect(page).to have_select('状態', selected: '公開')
      end
    end
  end
end
