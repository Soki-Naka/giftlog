class CommentLikesController < ApplicationController
  before_action :comment_params, only: %i[create destroy]
  def create
    CommentLike.create(user_id: current_user.id, comment_id: params[:id])
    # redirect_back(fallback_location: @post)
  end

  def destroy
    CommentLike.find_by(user_id: current_user.id, comment_id: params[:id]).destroy
    # redirect_back(fallback_location: @post)
  end

  private

  def comment_params
    @comment = Comment.find(params[:id])
  end
end
