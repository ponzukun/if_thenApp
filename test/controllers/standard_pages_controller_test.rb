require 'test_helper'

class StandardPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get standard_pages_home_url
    assert_response :success
  end

end
