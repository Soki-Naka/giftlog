class GiftsController < ApplicationController
  before_action :logged_in_user, only: %i[create]

  def new
    # @favorite_person = FavoritePerson.find_by(id: params[:id])
    @gift = Gift.new
  end

  def create
    @favorite_person = FavoritePerson.find_by(params[:favorite_person_id])
    @gift = @favorite_person.gifts.build(gift_params)

    if @gift.save
      flash[:success] = '登録が完了しました'
      # redirect_to controller: :favorite_people, action: :show, id: @favorite_person.id
      redirect_to root_url
    else
      render 'gifts/new'
    end
  end

  # def create
  #   @favorite_person = FavoritePerson.find_by(params[:favorite_person_id])
  #   @gift = @favorite_person.gifts.create(item: create_params[:item], situation: create_params[:situation], price: create_params[:price], when: create_params[:when], description: create_params[:description])

  #   if @gift.save
  #     flash[:success] = '登録が完了しました'
  #     redirect_to root_url
  #   else
  #     render 'gifts/new'
  #   end
  # end

  private

  # def create_params
  #   params.require(:gift).permit(:item, :situation, :price, :when, :description).merge(user_id: current_user.id)
  # end

  def gift_params
    params.require(:gift).permit(:item, :situation, :price, :when, :description)
  end
end
