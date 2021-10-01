require 'rails_helper'

RSpec.describe 'WriterArticles', type: :system do
  describe 'ユーザーの権限がライターのとき' do
    let(:writer) {create(:user, :writer)}
    before { login(writer) }
    it 'ホームページにタグ、著者、カテゴリータブが表示されない' do
      visit admin_articles_path
      within '.main-sidebar' do
        expect(page).not_to have_content('タグ')
        expect(page).not_to have_content('著者')
        expect(page).not_to have_content('カテゴリー')
      end
    end
    it 'categoryページのアクセスに失敗する' do
      visit admin_categories_path
      expect(page).to have_content("You don't have permission to access.")
    end
    it 'tagページのアクセスに失敗する' do
      visit admin_categories_path
      expect(page).to have_content("You don't have permission to access.")
    end
    it 'authorページのアクセスに失敗する' do
      visit admin_categories_path
      expect(page).to have_content("You don't have permission to access.")
    end
  end
end
