class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      # ログイン後にユーザー情報ページにリダイレクト
      log_in @user
      # チェックボックスがオンのときユーザーの保持
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_back_or root_url
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
