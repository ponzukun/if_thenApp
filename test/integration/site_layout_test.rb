require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @admin     = users(:michael)
    @non_admin = users(:archer)
  end

  test "layout links" do
    get root_path
    assert_template 'standard_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", login_path
  end

  test "layout links when logged in as a admin" do
    log_in_as(@admin)
    get root_path
    assert_template 'standard_pages/home'
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@admin), count: 3
    assert_select "a[href=?]", edit_user_path(@admin)
    assert_select "a[href=?]", logout_path
  end

  test "layout links when logged in as a non_admin" do
    log_in_as(@non_admin)
    get root_path
    assert_template 'standard_pages/home'
    assert_select "a[href=?]", user_path(@non_admin), count: 3
    assert_select "a[href=?]", edit_user_path(@non_admin)
    assert_select "a[href=?]", logout_path
  end
end
