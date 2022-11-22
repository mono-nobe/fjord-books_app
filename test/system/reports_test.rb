# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    # click_linkの完全一致のみ許可する
    Capybara.exact = true

    visit root_url
    fill_in 'Eメール', with: users(:alice).email
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'

    visit reports_path
  end

  test '日報の作成' do
    click_link '新規作成'
    fill_in 'タイトル', with: '日報の新規作成'
    fill_in '内容', with: '日報を新規作成します'
    click_button '登録する'

    assert_text '日報が作成されました。'
  end

  test '日報の編集' do
    click_link '編集', match: :first
    fill_in 'タイトル', with: '日報の編集'
    fill_in '内容', with: '日報を編集しました'
    click_button '更新する'

    assert_text '日報が更新されました。'
  end

  test '日報の削除' do
    page.accept_confirm do
      click_link '削除', match: :first
    end

    assert_text '日報が削除されました。'
  end
end
