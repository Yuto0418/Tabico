class RelationshipsController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!, except: [:index]

  def create
    user = User.find(params[:relationship][:follow_id])
    following = current_user.follow(user)
    if following.save
      flash[:notice] = 'フォローしました'
      redirect_to request.referer
    else
      flash.now[:notice] = 'フォローに失敗しました'
      redirect_to request.referer
    end
  end

  def destroy
    user = User.find(params[:relationship][:follow_id])
    following = current_user.unfollow(user)
    if following.destroy
      flash[:notice] = 'フォローを解除しました'
      redirect_to request.referer
    else
      flash.now[:notice] = 'フォロー解除に失敗しました'
      redirect_to request.referer
    end
  end

  private

  def set_user
    @user = User.find(params[:relationship][:follow_id])
  end
end
