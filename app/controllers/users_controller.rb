class UsersController < ApplicationController
  before_action :set_q
  before_action :authenticate_user!, except: [:index]

  def index
  end

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.all.order(created_at: :desc)
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザーIDが「#{@user.name}」の情報を更新しました"
      redirect_to action: :show
    else
      flash[:notice] = "情報の更新が失敗しました"
      render :edit
    end
  end

  def search
    @results = @q.result
    @count = @results.count
  end

  private

  def set_q
    @q = User.ransack(params[:q])
  end

  def user_params
    params.require(:user).permit(:image_name, :name, :description)
  end
end
