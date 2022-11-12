# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  # editableのテスト
  test 'editable_正常系_BobがBobの日報を編集する' do
    bob = User.find(2)
    bob_report_first = Report.find(3)

    assert bob_report_first.editable?(bob)
  end

  test 'editable_正常系_AliceがBobの日報を編集する' do
    alice = User.find(1)
    bob_report_first = Report.find(3)

    assert_not bob_report_first.editable?(alice)
  end

  # created_onのテスト
  test 'created_on_正常系_日報の作成時間を取得する' do
    alice_report_first = Report.find(1)
    alice_report_first_created_date = DateTime.new(2022, 1, 12, 11, 1, 45).to_date

    assert_equal alice_report_first_created_date, alice_report_first.created_on
  end
end
