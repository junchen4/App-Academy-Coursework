class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name],
                                     params[:user][:password]
                                    )
    if @user.nil?
      render :new
    else
      session[:session_token] = @user.session_token
      redirect_to user_url(@user.id)
    end

  end

  def destroy
    log_out!
    session[:session_token] = nil
    redirect_to subs_url
  end

end
