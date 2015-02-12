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
    session[:session_token] = nil
    current_user.reset_session_token!
  end

  # def require_user!
  #
  # end

end
