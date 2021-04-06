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
    # @comments_users_rank = User.find(Comment.group(:user_id).order('count(user_id) desc').limit(3).pluck(:user_id))

    # コメント回答数ランキング(途中)
    # posts = Post.arel_table
    # comments = Comment.arel_table
    # @comments_users_rank = User.joins(posts: :comments)
    # .where.not(posts[:user_id].eq(comments[:user_id]))
    # .group(posts[:user_id])
    # .select('users.*, COUNT(`posts`.`id`) AS comments_count')
    # .order('count(posts.user_id) DESC').limit(3)

    # コメントへのいいね獲得数ランキング
    if logged_in?
      comment_likes = CommentLike.arel_table
      @comments_likes_users_rank = User.joins(comments: :comment_likes).where.not(comment_likes[:user_id].eq(current_user.id)).group(comment_likes[:comment_id]).select('users.*, COUNT(`comment_likes`.`id`) AS comments_count').order('count(comment_id) DESC').limit(3)
    end
  end

  def about; end

  def contact; end
end
