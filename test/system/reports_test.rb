# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  include Warden::Test::Helpers
  setup do
    # click_linkの完全一致のみ許可する
    Capybara.exact = true

    @user = users(:alice)
    login_as(@user, scope: :user)

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
