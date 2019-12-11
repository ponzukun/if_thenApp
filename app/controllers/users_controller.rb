class UsersController < ApplicationController
  before_action :set_user,              only: %i[show edit update destroy correct_user allowed_user_destory]
  before_action :logged_in_user,        only: %i[index edit update destroy]
  before_action :correct_user,          only: %i[edit update]
  before_action :allowed_user_destory,  only: :destroy

  def index
    @users = User.paginate(page: params[:page]).search(params[:search])
  end

  def show
    @ifthen_rules = @user.ifthen_rules.paginate(page: params[:page], per_page: 15).search(params[:search])
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

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    if current_user.admin?
      @user.destroy
      flash[:success] = "User deleted"
      redirect_to users_url
    elsif current_user?(@user)
      @user.destroy
      flash[:success] = "Unsubscribed if-thenApp"
      redirect_to root_url
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
      # ↑の戻り値は、許可された属性のみが含まれたparamsのハッシュ (:user属性がない場合はエラー)。
    end

    # before_action

    def set_user
      @user = User.find(params[:id])
    end

    # 正しいユーザーかどうか確認
    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end

    # destoryアクションが許可されたユーザーかどうか確認
    def allowed_user_destory
      redirect_to(root_url) unless current_user.admin? || current_user?(@user)
    end
end
