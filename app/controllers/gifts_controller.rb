class GiftsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]

  def new
    @favorite_person = FavoritePerson.find(params[:favorite_person_id])
    @gift = Gift.new
  end

  def create
    @favorite_person = FavoritePerson.find(params[:favorite_person_id])
    @gift = @favorite_person.gifts.build(gift_params)

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
    flash[:success] = '登録情報を削除しました'
    redirect_to request.referer
  end

  def edit
    @gift = Gift.find(params[:id])
  end

  def update
    @gift = Gift.find(params[:id])
    if @gift.update(gift_params)
      flash[:success] = "#{@gift.favorite_person.name}に贈ったものの情報を更新しました"
      redirect_to controller: :favorite_people, action: :show, id: @gift.favorite_person_id
    else
      render '/gifts/edit'
    end
  end

  private

  def gift_params
    params.require(:gift).permit(:item, :situation, :price, :when, :description)
  end
end
