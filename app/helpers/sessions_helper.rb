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
end
