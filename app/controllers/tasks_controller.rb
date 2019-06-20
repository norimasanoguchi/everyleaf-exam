class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy, :show]

  def index
    if params[:sort_expired]
      @tasks = current_user.tasks.order("expiration_at DESC").page(params[:page]).per(PER)
    elsif params[:search]
      if params[:title_search]&&params[:status_search]
        @tasks = current_user.tasks.title_search(params[:title_search]).status_search(params[:status_search]).page(params[:page]).per(PER)
      elsif params[:title_search]
        @tasks = current_user.tasks.title_search(params[:title_search]).page(params[:page]).per(PER)
      elsif params[:task_search]
        @tasks = current_user.tasks.status_search(params[:status_search]).page(params[:page]).per(PER)
      end
    elsif params[:sort_priority]
      @tasks = current_user.tasks.order("priority ASC").page(params[:page]).per(PER)
    else
        @tasks = current_user.tasks.order_created_desc.page(params[:page]).per(PER)
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      redirect_to(tasks_path, notice:"タスクを作成しました")
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @task.update(task_params)
      redirect_to(tasks_path, notice:"編集しました")
    else
      render 'edit'
    end
  end

  def show

  end

  def destroy
    @task.destroy
    redirect_to(tasks_path, notice:"削除しました")
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :label, :priority, :status, :expiration_at)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  PER = 5

end
