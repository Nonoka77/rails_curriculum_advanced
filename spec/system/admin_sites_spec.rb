require 'rails_helper'

RSpec.describe 'AdminSites', type: :system do
  describe 'ブログのトップ画像を変更' do
    let(:admin) {create(:user, :admin)}
    before do
      login(admin)
      visit edit_admin_site_path
    end
    it 'トップ画像に複数枚の画像をアップロードできる' do
      attach_file('site_main_images', %w(spec/fixtures/images/kimetu.jpeg spec/fixtures/images/cat.png))
      click_on '保存'
      expect(page).to have_selector("img[src$='cat.png']")
      expect(page).to have_selector("img[src$='kimetu.jpeg']")
    end
    it 'トップ画像に１枚の画像をアップロードできる' do
      attach_file('site_main_images', 'spec/fixtures/images/kimetu.jpeg')
      click_on '保存'
      expect(page).to have_selector("img[src$='kimetu.jpeg']")
    end
    it 'トップ画像を削除できる' do
      attach_file('site_main_images', %w(spec/fixtures/images/kimetu.jpeg))
      click_on '保存'
      click_on '削除'
      expect(page).not_to have_selector("img[src$='kimetu.jpeg']")
    end
  end
  describe 'favicon画像を変更' do
    it 'faviconを削除できる' do
      attach_file('site_favicon', 'spec/fixtures/images/cat.png')
      click_on '保存'
      click_on '削除'
      expect(page).not_to have_selector("img[src$='cat.png']")
    end
  end
  describe 'og_image画像を変更' do
    it 'og_imageを削除できる' do
      attach_file('site_favicon', 'spec/fixtures/images/cat.png')
      click_on '保存'
      click_on '削除'
      expect(page).not_to have_selector("img[src$='cat.png']")
    end

  end
end
