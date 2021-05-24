class EventsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy edit update]

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = '登録が完了しました'
      redirect_to events_user_path(current_user)
    else
      render 'events/new'
    end
  end

  def show
    @event = Event.find_by(id: params[:id])
    @user  = User.find_by(id: current_user.id)
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:success] = '登録情報を削除しました'
    redirect_to events_user_path(current_user)
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:success] = '登録情報を更新しました'
      redirect_to events_user_path(current_user)
    else
      render '/events/edit'
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :start_time, :description)
  end
end
