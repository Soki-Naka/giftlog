class FavoritePeopleController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy edit update]
  # before_action :correct_user, only: %i[destroy]

  def new
    @favorite_person = FavoritePerson.new
  end

  def create
    @favorite_person = current_user.favorite_people.build(favorite_person_params)
    if @favorite_person.save
      flash[:success] = '登録が完了しました'
      redirect_to favorite_people_user_path(current_user)
    else
      render 'favorite_people/new'
    end
  end

  def show
    # @user = User.find_by(id: params[:id])
    @favorite_person = FavoritePerson.find_by(id: params[:id])
    @gifts = @favorite_person.gifts.page(params[:page]).per(5)
  end

  def destroy
    @favorite_person = FavoritePerson.find(params[:id])
    @favorite_person.destroy
    flash[:success] = '削除しました'
    redirect_to favorite_people_user_path(current_user)
  end

  def edit
    @favorite_person = FavoritePerson.find(params[:id])
  end

  def update
    @favorite_person = FavoritePerson.find(params[:id])
    if @favorite_person.update(favorite_person_params)
      flash[:success] = '編集しました'
      redirect_to favorite_people_user_path(current_user)
    else
      render '/favorite_people/edit'
    end
  end

  private

  def favorite_person_params
    params.require(:favorite_person).permit(:name, :image, :birthday, :description)
  end
end