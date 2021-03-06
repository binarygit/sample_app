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
                         email: @user.email,
                         password: ''
                       }
                     }
    assert_not is_logged_in?
    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert flash.any?
  end

  test 'login with valid credentials followed by logout' do
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
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # Simulate user clicking logout in a second window
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test 'login without remembering' do
    login_as @user, remember_me: 1
    delete logout_path
    login_as @user
    assert_empty cookies[:remember_token]
  end

  test 'login with remembering' do
    login_as @user, remember_me: '1'
    assert_not_empty cookies[:remember_token]
    assert_equal cookies[:remember_token], assigns(:user).remember_token
  end
end
