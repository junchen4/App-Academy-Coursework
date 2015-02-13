class UsersController < ApplicationController

  def index
    @user = User.all
    render :index
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def edit
    @user = current_user
    render :edit
  end

  def update
    @user = User.find_by_credentials(params[:user][:user_name],
                                     params[:user][:password]
                                    )

    if @user.update(user_params)
      redirect_to user_url(@user)
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def destroy
    @user = current_user

    if @user.destroy
      redirect_to users_url
    else
      redirect_to user_url(@user)
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end
