class CommentsController < ApplicationController
  def create
    tweet = Tweet.find(params[:tweet_id])
    @comment = tweet.comments.build(comment_params)
    if @comment.save
      flash[:notice] = "コメントしました"
      redirect_to tweet_path(tweet)
    else
      render tweet_path(tweet)
    end
  end

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @comment = @tweet.comments.find(params[:id])
    @comment.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to tweet_path(@tweet)
  end

  private

  def comment_params
    params.required(:comment).permit(:comment_text, :user_id, :tweet_id)
  end
end
