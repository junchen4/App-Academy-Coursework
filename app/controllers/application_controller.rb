class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  helper_method :current_user #makes method available to code in views

  def current_user
    current_user = User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    return true if sessions[:session_token] == current_user.session_token
    nil
  end

  def log_in_user!(user)
    session[:session_token] = user.reset_session_token!
  end


end
