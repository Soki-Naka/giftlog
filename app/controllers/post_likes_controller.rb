class PostLikesController < ApplicationController
  before_action :post_params
  def create
    PostLike.create(user_id: current_user.id, post_id: params[:id])
    # redirect_back(fallback_location: @posts)
  end

  def destroy
    PostLike.find_by(user_id: current_user.id, post_id: params[:id]).destroy
    # redirect_back(fallback_location: @posts)
  end

  private

  def post_params
    @post = Post.find(params[:id])
  end
end
