class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザーIDが「#{@user.name}」の情報を更新しました"
      redirect_to action: :edit
    else
      flash[:notice] = "情報の更新が失敗しました"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:image_name, :name)
  end
end
