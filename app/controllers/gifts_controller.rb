class GiftsController < ApplicationController
  before_action :logged_in_user, only: %i[create]

  def new
    @favorite_person = FavoritePerson.find_by(id: params[:id])
    @gift = Gift.new
  end

  def create
    # @favorite_person = FavoritePerson.find(params[:favorite_person_id])
    # @gift = @favorite_person.gifts.build(gift_params)
    # @gift = Gift.new
    # favorite_person = FavoritePerson.find(params[:id])
    # @gift = current_user.gifts.build
    @gift = Gift.new(gift_params)

    if @gift.save
      flash[:success] = '登録が完了しました'
      redirect_to root_url
    else
      render 'gifts/new'
    end
  end

  private

  def gift_params
    params.require(:gift).permit(:item, :situation, :price, :when, :description)
  end
end
