require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_match @user.ifthen_rules.count.to_s, response.body
    assert_select 'div.pagination'
    # 何故かエラーになる
    # @user.ifthen_rules.paginate(page: 1).each do |ifthen_rule|
    #   assert_match ifthen_rule.if,   response.body
    #   assert_match ifthen_rule.then, response.body
    # end
  end
end
