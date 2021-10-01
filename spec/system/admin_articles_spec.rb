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

  describe '検索機能' do
    let(:article_with_author) { create(:article, :with_author, author_name: '阿部') }
    let(:article_with_another_author) { create(:article, :with_author, author_name: '川添') }
    let(:article_with_tag) { create(:article, :with_tag, tag_name: 'Dog') }
    let(:article_with_another_tag) { create(:article, :with_tag, tag_name: 'Cat' )}
    let(:draft_article_with_sentence) { create(:article, :draft, :with_sentence, sentence_body: '基礎編アプリの記事')}
    let(:published_article_with_sentence) { create(:article, :published, :with_sentence, sentence_body: '基礎編アプリの記事')}
    let(:publish_wait_article_with_sentence) { create(:article, :publish_wait, :with_sentence, sentence_body: '基礎編アプリの記事')}
    let(:draft_article_with_another_sentence) { create(:article, :draft, :with_sentence, sentence_body: '応用編アプリの記事')}
    let(:published_article_with_another_sentence) { create(:article, :published, :with_sentence, sentence_body: '応用編アプリの記事')}
    let(:publish_wait_article_with_another_sentence) { create(:article, :publish_wait, :with_sentence, sentence_body: '応用編アプリの記事')}
    it '著者名で検索' do
      article_with_author
      article_with_another_author
      visit admin_articles_path
      within  'select[name="q[author_id]"]'do
        select '阿部'
      end
      click_button '検索'
      expect(page).to have_content(article_with_author.title)
      expect(page).not_to have_content(article_with_another_author.title)
    end
    it 'タグで検索' do
      article_with_tag
      article_with_another_tag
      visit admin_articles_path
      within  'select[name="q[tag_id]"]'do
        select 'Dog'
      end
      click_button '検索'
      expect(page).to have_content(article_with_tag.title)
      expect(page).not_to have_content(article_with_another_tag.title)
    end
    it  '公開状態の記事について、本文で絞り込み検索ができること' do
      visit edit_admin_article_path(published_article_with_sentence.uuid)
      click_on '公開する'
      visit edit_admin_article_path(published_article_with_another_sentence.uuid)
      click_on '公開する'
      visit admin_articles_path
      fill_in 'q[body]', with: '基礎編アプリの記事'
      click_button '検索'
      expect(page).to have_content(published_article_with_sentence.title), '公開状態の記事について、本文での検索ができていません'
      expect(page).not_to have_content(published_article_with_another_sentence.title), '公開状態の記事について、本文での絞り込みができていません'
    end

    it '公開待ち状態の記事について、本文で絞り込み検索ができること' do
      visit edit_admin_article_path(publish_wait_article_with_sentence.uuid)
      click_on '公開する'
      visit edit_admin_article_path(publish_wait_article_with_another_sentence.uuid)
      click_on '公開する'
      visit admin_articles_path
      fill_in 'q[body]', with: '基礎編アプリの記事'
      click_button '検索'
      expect(page).to have_content(publish_wait_article_with_sentence.title), '公開待ち状態の記事について、本文での検索ができていません'
      expect(page).not_to have_content(publish_wait_article_with_another_sentence.title), '公開待ち状態の記事について、本文での絞り込みができていません'
    end

    it '下書き状態の記事について、本文で絞り込み検索ができること' do
      draft_article_with_sentence
      draft_article_with_another_sentence
      visit admin_articles_path
      fill_in 'q[body]', with: '基礎編アプリ'
      click_button '検索'
      expect(page).to have_content(draft_article_with_sentence.title), '下書き状態の記事について、本文での検索ができていません'
      expect(page).not_to have_content(draft_article_with_another_sentence.title), '下書き状態の記事について、本文での絞り込みができていません'
    end
  end
end

