require 'test_helper'

class IfthenRulesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @ifthen_rule = ifthen_rules(:youtube)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'IfthenRule.count' do
      post ifthen_rules_path, params: { ifthen_rule: { if_content:   "I want to sleep again",
                                                       then_content: "Hit the cheek" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'IfthenRule.count' do
      delete ifthen_rule_path(@ifthen_rule)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong ifthen_rule" do
    log_in_as(users(:michael))
    ifthen_rule = ifthen_rules(:ants)
    assert_no_difference 'IfthenRule.count' do
      delete ifthen_rule_path(ifthen_rule)
    end
    assert_redirected_to root_url
  end
end
