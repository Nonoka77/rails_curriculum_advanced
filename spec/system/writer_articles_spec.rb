require 'rails_helper'

RSpec.describe 'WriterArticles', type: :system do
  describe 'ユーザーの権限がライターのとき' do
    let(:writer) {create(:user, :writer)}
    before do
      driven_by(:rack_test)
      login(writer)
      visit admin_articles_path(writer)
    end
    it 'ホームページにタグ、著者、カテゴリータブが表示されない' do
      within '.main-sidebar' do
        expect(page).not_to have_content('タグ')
        expect(page).not_to have_content('著者')
        expect(page).not_to have_content('カテゴリー')
      end
    end
    it 'categoryページのアクセスに失敗する' do
      visit admin_categories_path
      expect(page).to have_http_status(403)
    end
    it 'tagページのアクセスに失敗する' do
      visit admin_tags_path
      expect(page).to have_http_status(403)
    end
    it 'authorページのアクセスに失敗する' do
      visit admin_authors_path
      expect(page).to have_http_status(403)
    end
  end
end
