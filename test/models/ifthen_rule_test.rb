require 'test_helper'

class IfthenRuleTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    # 紐付いているユーザーを通して、作成（buildはオブジェクトを返すがDBに反映されない）
    @ifthen = @user.ifthen_rules.build(if_content: "When I watch Youtube", then_content: "Meditate!")
  end

  test "should be valid" do
    assert @ifthen.valid?
  end

  test "user id should be present" do
    @ifthen.user_id = nil
    assert_not @ifthen.valid?
  end

  test "'if' should be present" do
    @ifthen.if_content = "   "
    assert_not @ifthen.valid?
  end

  test "'if' should be at most 100 characters" do
    @ifthen.if_content = "a" * 101
    assert_not @ifthen.valid?
  end

  test "'then' should be present" do
    @ifthen.then_content = "   "
    assert_not @ifthen.valid?
  end

  test "'then' should be at most 100 characters" do
    @ifthen.then_content = "a" * 101
    assert_not @ifthen.valid?
  end

  test "order should be most recent first" do
    assert_equal ifthen_rules(:most_recent), IfthenRule.first
  end
end
