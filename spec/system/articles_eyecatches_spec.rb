require 'rails_helper'

RSpec.describe 'AdminAritclesEyecatches', type: :system do
  let(:admin) { create :user, :admin }
  let!(:article) { create :article }

  before do
    login(admin)
    visit edit_admin_article_path(article.uuid)
    attach_file 'article[eye_catch]', "#{Rails.root}/spec/fixtures/images/kimetu.jpeg"
    click_on '更新する'
  end

  describe 'アイキャッチ表示位置機能' do
    context 'アイキャッチが指定した位置に表示される' do
      it '左寄せを指定したとき' do
        choose '左寄せ'
        expect(page).to have_checked_field '左寄せ'
        click_on '更新する'
        click_on 'プレビュー'
        switch_to_window windows.last
        expect(page).to have_selector("section.eye_catch.text-left")
      end
      it '中央揃えを指定したとき' do
        choose '中央揃え'
        expect(page).to have_checked_field '中央揃え'
        click_on '更新する'
        click_on 'プレビュー'
        switch_to_window windows.last
        expect(page).to have_selector("section.eye_catch.text-center")
      end
      it '右寄せを指定したとき' do
        choose '右寄せ'
        expect(page).to have_checked_field '右寄せ'
        click_on '更新する'
        click_on 'プレビュー'
        switch_to_window windows.last
        expect(page).to have_selector("section.eye_catch.text-right")
      end
    end
    context 'アイキャッチ横幅調整機能' do
      it '100以上700未満のとき、正常に表示される' do
        eyecatch_width = rand(100..700)
        click_on 'プレビュー'
        switch_to_window windows.last
        expect(page).to have_selector("img[src$='kimetu.jpeg']")
      end
      it '100以下のときにエラーが表示される' do
        fill_in 'アイキャッチ幅', with: rand(99)
        click_on '更新する'
        expect(page).to have_content('100以上の値にしてください')
      end
      it '700以上のときにエラーが表示される' do
        fill_in 'アイキャッチ幅', with: rand(701..1000)
        click_on '更新する'
        expect(page).to have_content('700以下の値にしてください')
      end
    end
  end
end

