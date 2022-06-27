module SessionsHelper
  # Logs in the given user
  def login(user)
    session[:user_id] = user.id
  end

  # Retuns the current user
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        login user
        @current_user = user
      end
    end
  end

  # Returns true when a user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user
  def logout
    session.delete(:user_id)
    @current_user = nil
  end

  # Sets cookies to remember user
  def remember(user)
    user.remember
    cookies.encrypted.permanent[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
end
