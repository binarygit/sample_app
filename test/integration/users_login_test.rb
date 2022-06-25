require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest

  test 'Error message is displayed when login attempt is unsuccessful' do
    get login_path
    assert_template 'sessions/new'

    post login_path, params: {
                       sessions: {
                         email: 'avi@avi.com',
                         password: 'avi'
                       }
                     }
    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert flash.any?
  end
end
