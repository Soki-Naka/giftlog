class GiftsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]

  def new
    @favorite_person = FavoritePerson.find(params[:favorite_person_id])
    @gift = Gift.new
  end

  def create
    # @user = User.find_by(params[:user_id])
    # logger.debug(@favorite_person.name)

    # @favorite_person = FavoritePerson.find_by(user_id: current_user.id)
    # @favorite_person = FavoritePerson.find(params[:id])
    # @favorite_person = FavoritePerson.find_by(params[:favorite_person_id])
    @favorite_person = FavoritePerson.find(params[:favorite_person_id])
    # @favorite_person = FavoritePerson.find_by(id: params[:favorite_person_id])
    # logger.debug(@favorite_person.name)
    # @gift = Gift.create(gift_params)
    @gift = @favorite_person.gifts.build(gift_params)

    # @gift = current_user.gifts.build(gift_params)
    # @gift = Gift.new(gift_params)
    # @gift = Gift.new(**gift_params, favorite_person_id: @favorite_person.id)

    if @gift.save
      flash[:success] = '登録が完了しました'
      redirect_to controller: :favorite_people, action: :show, id: @favorite_person.id
    else
      render 'gifts/new'
    end
  end

  def destroy
    @gift = Gift.find(params[:id])
    @gift.destroy
    flash[:success] = '削除しました'
    redirect_to request.referer
  end

  def edit
    @gift = Gift.find(params[:id])
  end

  def update
    @gift = Gift.find(params[:id])
    if @gift.update(gift_params)
      flash[:success] = '投稿を編集しました'
      redirect_to controller: :favorite_people, action: :show, id: @gift.favorite_person_id
    else
      render '/gifts/edit'
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

  # def gift_params
  #   params.require(:gift).permit(:item, :situation, :price, :when, :description).merge(favorite_person_id: favorite_person.id)
  # end
end
