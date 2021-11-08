class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @tweet.comments.create(comment_params)
    if @comment.save
      redirect_to tweet_path(@tweet) notice: 'コメントしました'
    else
      flash.now[:alert] = 'コメントに失敗しました'
      render tweet_path(@tweet)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to tweet_path(@tweet), notice: 'コメントを削除しました'
    else
      flash.now[:alert] = 'コメント削除に失敗しました'
      render tweet_path(@tweet)
    end
  end

  private
  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def comment_params
    params.required(:comment).permit(:comment_text, :user_id).merge(tweet_id: params[:tweet_id])
  end
end
