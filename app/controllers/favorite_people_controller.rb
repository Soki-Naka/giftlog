class FavoritePeopleController < ApplicationController
  before_action :logged_in_user, only: %i[create]

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
    @favorite_person = FavoritePerson.find_by(id: params[:id])
  end

  private

  def favorite_person_params
    params.require(:favorite_person).permit(:name, :image, :birthday, :description)
  end
end
