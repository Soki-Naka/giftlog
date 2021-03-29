class CommentLikesController < ApplicationController
  before_action :comment_params, only: %i[create destroy]
  def create
    CommentLike.create(user_id: current_user.id, comment_id: params[:id])
  end

  def destroy
    CommentLike.find_by(user_id: current_user.id, comment_id: params[:id]).destroy
  end

  private

  def comment_params
    @comment = Comment.find(params[:id])
  end
end

# redirect_back(fallback_location: @post)
