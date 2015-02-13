class SessionsController < ApplicationController

  def create
    if current_user.nil?
      return nil
    else
      session[:session_token] = current_user.session_token
    end
  end

  def destroy
    log_out!
    session[:session_token] = nil
  end

end
