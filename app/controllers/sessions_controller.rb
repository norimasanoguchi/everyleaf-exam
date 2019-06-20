class SessionsController < ApplicationController
  skip_before_action :login_required
  def new
    redirect_to(tasks_path, danger:"既にログインしています") if current_user.present?
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to(user_path(user.id))
    else
      flash.now[:danger] = t("log_in_page.failed_login")
      render "new"
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:info] = t("log_in_page.logged_out")
    redirect_to(new_session_path)
  end
end
