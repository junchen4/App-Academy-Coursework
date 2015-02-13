class UsersController < ApplicationController


  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in(@user)
      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def edit
    @user = current_user

    if @user.nil? || params[:id] != @user.id
      #error message can't edit other user
      redirect_to subs_url
    else
      render :edit
    end
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      redirect_to user_url(@user)
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])

    if @user.nil? || params[:id] != @user.id
      #error message can't view other user
      redirect_to subs_url
    else
      render :show
    end
  end

  def destroy
    @user = current_user

    if @user.destroy
      redirect_to subs_url
    else
      redirect_to user_url(@user)
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end
