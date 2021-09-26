require 'rails_helper'

RSpec.describe 'AdminArticlesPreview', type: :system do
  let(:admin) {create :user, :admin } #role(権限)がadminのuserを作成し、変数adminに代入する
  before { login(admin) }

  describe '記事作成画面で画像ブロックを追加' do
    context  '画像を添付せずにプレビューを閲覧' do
      it '正常に表示される' do
        visit admin_articles_path
        click_on '新規作成'
        fill_in 'タイトル', with: 'title-1'
        click_on '登録する'
        click_on 'ブロックを追加する'
        click_on '画像'
        click_on 'プレビュー'
        switch_to_window windows.last
        expect(page).not_to have_content("Nil location provided. Can't build URI"), 'エラーページが表示されています'
        expect(page).to have_content('title-1'), 'プレビューページが正しく表示されていません'
      end
    end
  end
    describe '記事作成画面で文章ブロックを追加' do
      let!(:article) { create :article }
      context  '文章を記入せずプレビューを閲覧' do
        it '正常に表示される' do
          visit edit_admin_article_path(article.uuid)
          click_on 'ブロックを追加する'
          click_on '文章'
          click_on 'プレビュー'
          switch_to_window windows.last
          expect(page).not_to have_content( "no implicit conversion of nil into String"), 'エラーページが表示されています'
          expect(page).to have_content(article.title), 'プレビューページが正しく表示されていません'
        end
      end
    end
end
