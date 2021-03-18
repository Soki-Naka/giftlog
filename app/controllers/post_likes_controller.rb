class PostLikesController < ApplicationController
  def create
    PostLike.create(user_id: current_user.id, post_id: params[:id])
    redirect_back(fallback_location: @posts)
  end

  def destroy
    PostLike.find_by(user_id: current_user.id, post_id: params[:id]).destroy
    redirect_back(fallback_location: @posts)
  end
end
