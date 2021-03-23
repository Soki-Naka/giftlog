class PostsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]
  before_action :correct_user, only: %i[destroy update]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '投稿が完了しました'
      redirect_to root_url
    else
      render 'posts/new'
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    @comments = @post.comments.page(params[:page])
    @comment = Comment.new
  end

  def destroy
    @post.destroy
    flash[:success] = '投稿を削除しました'
    redirect_to request.referer || root_url
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(params[:id])
    if @post.update(post_params)
      flash[:success] = '投稿を編集しました'
      redirect_to root_url
    else
      render '/posts/edit'
    end
  end

  private

  def post_params
    params.require(:post).permit(:who, :gender, :age, :job, :situation, :item, :price, :when, :description)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end
