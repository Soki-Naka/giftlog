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

    # コメントへのいいね獲得数ランキング
    # if logged_in?
    #   comment_likes = CommentLike.arel_table
    #   @comments_likes_users_rank = User.joins(comments: :comment_likes).where.not(comment_likes[:user_id].eq(current_user.id)).group(comment_likes[:comment_id]).select('users.*, COUNT(`comment_likes`.`id`) AS comments_count').order('count(comment_id) DESC').limit(3)
    # end

    comment_likes = CommentLike.arel_table
    comments = Comment.arel_table
    # これいじる↓
    # posts = Post.arel_table

    # コメント回答数ランキング(自分の投稿へのコメントも含む)
    # @comments_users_rank = User.find(Comment.group(:user_id).order('count(user_id) desc').limit(3).pluck(:user_id))
    # これいじる↓
    # @comments_users_rank = User.joins(posts: :comments).where.not(posts[:user_id].eq(comments[:user_id])).group(comments[:user_id]).select('users.*, COUNT(`comments`.`id`) AS comments_count').order('count(comments.user_id) DESC').limit(3)

    # @comments_users_rank = User.find(Comment.group(comments[:user_id]).select('users.*, COUNT(`comments`.`id`) AS comments_count').order('count(comment_id) desc').limit(3))
    # コメント回答数ランキング(自分の投稿へのコメントも含む)(修正版)↓
    # @comments_users_rank = User.joins(:comments).group(comments[:user_id]).select('users.*, COUNT(`comments`.`id`) AS comments_count').order('count(user_id) desc').limit(3)

    # 6月24日
    # @comments_users_rank = User.joins(posts: :comments).where.not(posts[:user_id].eq(comments[:user_id])).group(:id).select('users.*, COUNT(`comments`.`id`) AS comments_count').order('count(comments.id) DESC').limit(3)

    # 5月26日↓
    # @comments_users_rank = User.joins(:comments, :posts).group(comments[:user_id]).where.not(comments[:user_id].eq(posts[:user_id])).select('users.*, COUNT(`comments`.`id`) AS comments_count').order('count(comments.id) desc').limit(3)

    # コメントへのいいね獲得数ランキング
    @comments_likes_users_rank = User.joins(comments: :comment_likes).where.not(comment_likes[:user_id].eq(comments[:user_id])).group(comments[:user_id]).select('users.*, COUNT(`comment_likes`.`id`) AS comment_likes_count').order('count(comment_id) DESC').limit(3)
  end

  def about; end

  def contact; end
end
