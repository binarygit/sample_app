require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "Error Messages are displayed when sign up attempt is unsuccessful" do
    get signup_path
    assert_response :success

    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: 'Avi'} }
    end
    assert_response :unprocessable_entity
    assert_template 'users/new'
    assert_select '#error_explanation'
  end

  test "New user is created when sign up attemt is successful" do
    get signup_path
    assert_response :success

    assert_difference 'User.count', 1 do
      post users_path, params: {
                          user: { 
                            name: 'Avi',
                            email: 'avi@avi.com',
                            password: 'foobar',
                            password_confirmation: 'foobar'
                          } 
                       }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_template 'users/show'
    assert_select '.alert.alert-success'
  end
end
