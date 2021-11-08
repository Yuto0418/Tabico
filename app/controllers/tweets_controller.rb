class TweetsController < ApplicationController
  def index
    @tweets = Tweet.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    if @tweet.save
      flash[:notice] = "投稿しました"
      redirect_to @tweet
    else
      render "new"
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comment = Comment.new
    @comments = @tweet.comments
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to :tweets
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body, :image, :user_id)
  end
end
