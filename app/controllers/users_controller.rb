class UsersController < ApplicationController

  def index
  end
  def show
    @user = User.find(current_user.id)
  end
  def update
    @user = User.find(current_user.id)
    if current_user.update(user_params)
      flash[:notice] = "ユーザーIDが「#{@user.name}」の情報を更新しました"
      redirect_to action: :show
    else
      flash[:notice] = "情報の更新が失敗しました"
      render :profile
    end
  end

  private
  def user_params
    params.require(:user).permit(:image_name, :name)
  end
end
