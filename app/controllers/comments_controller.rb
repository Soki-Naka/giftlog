class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = 'コメントを投稿しました'
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
end
