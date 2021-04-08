class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update following followers favorite_people]
  before_action :correct_user,   only: %i[edit update]

  def index
    @users = User.all.page(params[:page]).per(5)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'ユーザー登録が完了しました'
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'プロフィールを更新しました'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def following
    @title = 'フォロー'
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(5)
    render 'show_followings'
  end

  def followers
    @title = 'フォロワー'
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(5)
    render 'show_followers'
  end

  def post_likes
    @user = User.find(params[:id])
    @posts = @user.liked_posts.page(params[:page]).per(5)
  end

  def comments
    @user = User.find(params[:id])
    @posts = @user.commented_posts.distinct.page(params[:page]).per(5)
  end

  def favorite_people
    @title = '大切な人リスト'
    @user  = User.find(params[:id])
    @favorite_people = @user.favorite_people.page(params[:page]).per(5)
    render 'show_favorite_people'
  end

  # def comment_likes
  #   @user = User.find(params[:id])
  #   @posts = @user.liked_comments_posts.distinct.page(params[:page]).per(5)
  #   @comments = @user.comment_likes.distinct
  # end

  private

  def user_params
    params.require(:user).permit(:image, :remove_image, :name, :email, :password, :password_confirmation, :gender, :age, :job, :prefecture, :introduction)
  end

  # beforeアクション

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
