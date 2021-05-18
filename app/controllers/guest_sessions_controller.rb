class GuestSessionsController < ApplicationController
  skip_before_action :login_required, raise: false

  def create
    user = User.find_by(email: 'test@example.com')
    log_in(user)
    flash[:success] = 'ゲストユーザーでログインしました'
    flash[:warning] = 'ゆっくりしていってください！'
    redirect_to user
  end
end
