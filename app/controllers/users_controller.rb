class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
      # ↑は、redirect_to user_url(@user) と等価
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
      # ↑の戻り値は、許可された属性のみが含まれたparamsのハッシュ (:user属性がない場合はエラー)。
    end
end
