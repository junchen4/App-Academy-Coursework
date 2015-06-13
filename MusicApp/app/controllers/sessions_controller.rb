class SessionsController < ApplicationController
  # before_action :require_user!

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email])
    if @user.nil?
      flash.now[:errors] = ["Login information not correct"]
      render :new
    else
      log_in_user!(@user)
      redirect_to user_url(@user)
    end
  end

  def destroy
    current_user.reset_session_token! #this must come BEFORE next line;
    #otherwise, current_user will be nil as soon as the session[token] is reset
    session[:session_token] = nil
    redirect_to new_session_url
  end

  # def require_user!
  #
  # end

end
