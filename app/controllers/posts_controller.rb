class PostsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]
  before_action :correct_user, only: %i[destroy edit update]

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
    @comment = Comment.new
    @comments = @post.comments
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = '投稿を削除しました'
    redirect_to @post.user
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = '投稿を編集しました'
      redirect_to @post.user
    else
      render '/posts/edit'
    end
  end

  def search
    @posts = Post.all.page(params[:page])
    if params[:gender].present?
      @posts = @posts.get_by_gender params[:gender]
      @posts = @posts.page(params[:page]).per(5)
    end
    if params[:age].present?
      @posts = @posts.get_by_age params[:age]
      @posts = @posts.page(params[:page]).per(5)
    end
    if params[:situation].present?
      @posts = @posts.get_by_situation params[:situation]
      @posts = @posts.page(params[:page]).per(5)
    end
    if params[:price].present?
      @posts = @posts.get_by_price params[:price]
      @posts = @posts.page(params[:page]).per(5)
    end
    if params[:gender].blank? && params[:age].blank? && params[:situation].blank? && params[:price].blank?
      flash[:warning] = '条件を指定してください'
      redirect_to root_url
    end
  end

  private

  def post_params
    params.require(:post).permit(:who, :gender, :age, :job, :situation, :item, :image, :remove_image, :price, :when, :description)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end
