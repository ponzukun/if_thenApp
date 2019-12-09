require 'test_helper'

class IfthenRulesInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "ifthen_rule interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    assert_select 'input[type="file"]'
    # 無効な通信
    assert_no_difference 'IfthenRule.count' do
      post ifthen_rules_path, params: { ifthen_rule: { if: "", then: "" } }
    end
    assert_select 'div#error_explanation'
    # 有効な通信
    IF   = "when I watched Youtube"
    THEN = "Meditate!"
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    assert_difference 'IfthenRule.count', 1 do
      post ifthen_rules_path, params: { ifthen_rule: { if: IF, then: THEN, picture: picture } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match IF,   response.body
    assert_match THEN, response.body
    # 投稿を削除する
    assert_select 'a', text: 'delete'
    first_ifthen_rule = @user.ifthen_rules.paginate(page: 1).first
    assert_difference 'IfthenRule.count', -1 do
      delete ifthen_rule_path(first_ifthen_rule)
    end
    # 違うユーザーのプロフィールにアクセス（削除リンクがないことを確認）
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
end
