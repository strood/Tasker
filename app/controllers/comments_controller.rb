class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id

    # render json: @comment

    if @comment.save
      flash[:notice] = ["Comment Saved"]

    else
      flash[:errors] = @comment.errors.full_messages


    end
    redirect_back fallback_location: users_url
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :imageable_id, :imageable_type)
  end
end
