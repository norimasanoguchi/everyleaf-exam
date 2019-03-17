class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy, :show]

  def index
    if params[:sort_expired]
      @tasks = Task.all.order("expiration_at DESC")
    else
      @tasks = Task.all.order("created_at DESC")
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

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
    @task = Task.find(params[:id])
  end

end
