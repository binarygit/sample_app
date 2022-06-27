require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:avi)
  end

  test 'Error message is displayed when login attempt is unsuccessful' do
    get login_path
    assert_template 'sessions/new'

    post login_path, params: {
                       session: {
                         email: 'avi@avi.com',
                         password: 'avi'
                       }
                     }
    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert flash.any?
  end

  test 'User is redirected to users#show page when login attempt is successful' do
    get login_path
    assert_template 'sessions/new'

    post login_path, params: {
      session: {
        email: 'avi@avi.com',
        password: 'foobar'
      }
    }
    assert_redirected_to @user
    follow_redirect!
    assert_equal @user.id, session[:user_id]
    assert_template 'users/show'
  end
end
