require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:avi)
  end

  test 'login with invalid credentials' do
    get login_path
    assert_template 'sessions/new'

    post login_path, params: {
                       session: {
                         email: '',
                         password: ''
                       }
                     }
    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert flash.any?
  end

  test 'login with valid email/invalid password' do
    get login_path
    assert_template 'sessions/new'

    post login_path, params: {
                       session: {
                         email: 'avi@avi.com',
                         password: ''
                       }
                     }
    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert flash.any?
  end

  test 'login with valid credentials' do
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
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', user_path(@user)
  end
end
