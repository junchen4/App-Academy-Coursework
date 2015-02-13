class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user_name

  def current_user
    user = User.find_by(session_token: session[:session_token])
    return nil if user.nil?
    user
  end

  def current_user_name
    return nil if current_user.nil?
    current_user.user_name
  end

  def log_in(user)
    session[:session_token] = user.session_token
  end

  def log_out!
    current_user.reset_session_token!
  end

  def logged_in?
    !current_user.nil?
  end


end
