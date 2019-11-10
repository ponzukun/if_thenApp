require 'test_helper'

class StandardPagesControllerTest < ActionDispatch::IntegrationTest

  # def setup
  #   @base_title = "if-thenプランニング"
  # end

  test "should get root" do
    get root_path
    assert_response :success
    # assert_select "title", "#{@base_title}"
  end

end
