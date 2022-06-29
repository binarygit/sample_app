require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  def setup
    @user = users(:avi)
    remember @user
  end

  test 'Current user returns right user when session is nil' do
    assert_equal @user, current_user
    assert logged_in?
  end

  test 'Current user returns nil when remember digest is wrong' do
    # Updates the remember digest
    @user.remember
    assert_nil current_user
  end
end
