require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
    @user = users(:avi)
  end

  test "should get new" do
    get signup_path
    assert_response :success
    assert_select 'title', "Sign up | #{ @base_title }"
  end

  test "should get show" do
    get user_path(@user)
    assert_response :success
    assert_select 'title', "#{ @user.name } | #{ @base_title }"
  end
end
