class Admin::UsersController < ApplicationController
  before_action :require_admin

  def index
    @users = User.all.includes(:tasks).page(params[:page]).per(25)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to(admin_users_path, success: "ユーザー#{@user.name}を登録しました")
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to(admin_user_path(@user), success: "ユーザー#{@user.name}を更新しました")
    else
      render :edit
    end
  end

  def destroy
      @user = User.find(params[:id])
      @user.destroy
      if @user.destroyed?
        redirect_to(admin_users_path, success: "ユーザー#{@user.name}を削除しました")
      else
        redirect_to(admin_users_path, danger: "唯一の管理ユーザーです。管理ユーザーをすべて削除することはできません。")
      end
  end

  private
  def require_admin
    # redirect_to root_path unless current_user.admin?
    raise unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end
end
