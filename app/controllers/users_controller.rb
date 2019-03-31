class UsersController < ApplicationController
  skip_before_action :login_required
  def new
    if current_user.present?
      redirect_to(tasks_path, danger:"既にログインしています")
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to(user_path(@user.id))
    else
      render 'new'
    end
  end

  def show
    if current_user == User.find(params[:id])
      @user = User.find(params[:id])
    else
      redirect_to(tasks_path, danger:"ユーザーが異なります。詳細ページを見るにはログインしなおしてください")
    end
  end

  private
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
