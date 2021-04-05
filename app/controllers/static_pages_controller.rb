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

    # コメント回答数ランキング(自分の投稿へのコメントも含む)
    @comments_users_rank = User.find(Comment.group(:user_id).order('count(user_id) desc').limit(3).pluck(:user_id))

    # コメントへのいいね獲得数ランキング
    # @comments_likes_users_rank = User.joins(comments: :comment_likes).where(CommentLike.group(:user_id).order('count(user_id) desc').limit(3).pluck(:user_id))

    # .group("liked_comments.id").order("count(liked_comments.user_id) desc")
    # .sort {|a,b| b.liked_comments.size <=> a.liked_comments.size}
  end

  def about; end

  def contact; end
end
