class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update destroy following followers favorite_people events]
  before_action :correct_user,   only: %i[edit update favorite_people events]
  before_action :admin_user, only: :destroy

  def index
    @users = User.all.page(params[:page]).per(5) if params[:name].blank?
    # パラメータとして名前を受け取っている場合は絞って検索する
    if params[:name].present?
      @users = User.all
      @users = @users.get_by_name params[:name]
      @users = @users.page(params[:page]).per(5)
    end
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
    if !guest_user
      @user = User.find(params[:id])
    else
      flash[:danger] = 'ゲストユーザーはプロフィールを編集できません'
      redirect_to @user
    end
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

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    if @user.destroy
      flash[:success] = 'ユーザーを削除しました'
      redirect_to users_url
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

  def favorite_people
    @title = '大切な人リスト'
    @user  = User.find(params[:id])
    if params[:name].present?
      @favorite_people = @user.favorite_people.all
      @favorite_people = @favorite_people.get_by_name params[:name]
      @favorite_people = @favorite_people.page(params[:page]).per(5)
    else
      @favorite_people = @user.favorite_people.page(params[:page]).per(5)
    end
    render 'show_favorite_people'
  end

  def events
    @title = 'カレンダー'
    @user  = User.find(params[:id])
    @events = @user.events.all
    render 'show_events'
  end

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

  # 管理者か確認
  def admin_user
    if current_user.admin.blank?
      flash[:danger] = '権限がありません'
      redirect_to(root_url)
    end
  end
end
