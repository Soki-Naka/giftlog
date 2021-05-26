class CommentsController < ApplicationController
  before_action :admin_user, only: :destroy

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = 'コメントを投稿しました'
      @post.create_notification_comment!(current_user, @comment.id)
    else
      flash[:danger] = 'コメントを投稿できませんでした'
    end
    redirect_back(fallback_location: @post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    if @comment.destroy
      flash[:success] = 'コメントを削除しました'
      redirect_back(fallback_location: @post)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  # 管理者かコメント投稿者かどちらかであるか確認
  def admin_user
    @comment = Comment.find(params[:id])
    if current_user.admin.blank? && current_user != @comment.user
      flash[:danger] = '権限がありません'
      redirect_to(root_url)
    end
  end
end
