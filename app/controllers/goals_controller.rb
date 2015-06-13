class GoalsController < ApplicationController
  before_action :must_be_logged_in
  before_action :must_have_permission, only: [:show, :edit, :update, :destroy]

  def index
    render :index
  end

  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user = current_user
    if @goal.save
      redirect_to goal_url(@goal)
    else
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
    render :edit
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      render :edit
    end
  end

  def show
    @goal = Goal.find(params[:id])
    render :show
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to goals_url
  end

  private
  def goal_params
    params.require(:goal).permit(:body, :public, :completed)
  end

  def must_have_permission
    @goal = Goal.find(params[:id])
    unless @goal.user == current_user || @goal.public?
      redirect_to goals_url
    end

  end

end
