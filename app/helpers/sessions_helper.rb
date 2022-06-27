module SessionsHelper
  # Logs in the given user
  def login(user)
    session[:user_id] = user.id
  end

  # Retuns the current user
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
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
end
