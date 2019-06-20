class Admin::LabelsController < ApplicationController
  before_action :require_admin

  def index
    @labels = Label.all
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)

    if @label.save
      redirect_to(admin_labels_path, success: "ラベルを登録しました")
    else
      render :new
    end
  end

  def destroy
      @label = Label.find(params[:id])
      @label.destroy
      redirect_to(admin_labels_path, success: "ラベル「#{@label.label}」を削除しました")
  end

  private
  def require_admin
      raise unless current_user.admin?
  end

  def label_params
    params.require(:label).permit(:label)
  end
end
