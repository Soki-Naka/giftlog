class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @posts_all = Post.all.page(params[:page]).per(5)
      @user = User.find(current_user.id)
      @follow_users = @user.following
      @posts = @posts_all.where(user_id: @follow_users).or(@posts_all.where(user_id: @user)).order('created_at DESC')
    else
      @posts = Post.all.page(params[:page]).per(5)
    end
  end

  def about; end

  def contact; end
end
