class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user_name,
                :current_user_id

  def redirect_if_not_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def redirect_if_not_mod
    sub = Sub.find(params[:id])
    redirect_to subs_url unless !current_user.nil? && current_user.id == sub.mod_id
  end

  def redirect_if_not_author
    post = Post.find(params[:id])
    redirect_to post_url(post) unless !current_user.nil? && current_user.id == post.author_id
  end

  def current_user
    user = User.find_by(session_token: session[:session_token])
    return nil if user.nil?
    user
  end

  def current_user_name
    return nil if current_user.nil?
    current_user.user_name
  end

  def current_user_id
    return nil if current_user.nil?
    current_user.id
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
