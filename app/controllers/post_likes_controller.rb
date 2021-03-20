class PostLikesController < ApplicationController
  before_action :post_params, only: %i[create destroy]
  def create
    PostLike.create(user_id: current_user.id, post_id: params[:id])
  end

  def destroy
    PostLike.find_by(user_id: current_user.id, post_id: params[:id]).destroy
  end

  private

  def post_params
    @post = Post.find(params[:id])
  end
end
