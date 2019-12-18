require 'test_helper'

class StandardPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "If-Then App"
    @user = users(:michael)
  end

  test "should get root" do
    get root_path
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end

  test "should get new" do
    log_in_as(@user)
    get new_path
    assert_response :success
    assert_select "title", "New | #{@base_title}"
  end

end
