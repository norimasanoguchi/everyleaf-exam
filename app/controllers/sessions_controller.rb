class SessionsController < ApplicationController
  def new
  end

  def created
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to(user_path(user.id))
    else
      flash.now[:danger] = t("log_in_page.failed_login")
      render "new"
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = t("log_in_page.logged_out")
  end
end
