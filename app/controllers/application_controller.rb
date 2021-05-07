class ApplicationController < ActionController::Base
<<<<<<< HEAD
  def hello
    render html: 'hello, world!'
=======
  include SessionsHelper

  private

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'ログインしてください'
      redirect_to login_url
    end
>>>>>>> origin/master
  end
end
