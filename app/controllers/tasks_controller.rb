class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy, :show]
  before_action :set_labels, only: [:new, :create,:edit, :update]
 
  def index
     # @labels_names = Label.all.map(&:label)
     @labels = Label.all.map{|t|[t.label,t.id]}


    if params[:sort_expired]
      @tasks = current_user.tasks.order("expiration_at DESC").page(params[:page]).per(PER)
    elsif params[:search]
      if params[:label_search].present?
        @task_ids = TasksLabel.all.label_id_search(params[:label_search]).pluck(:task_id)
        @tasks = Task.all.task_id_search(@task_ids).page(params[:page]).per(PER)
      elsif params[:title_search].present? && params[:status_search].present?
        @tasks = current_user.tasks.title_search(params[:title_search]).status_search(params[:status_search]).page(params[:page]).per(PER)
      elsif params[:title_search].present?
        @tasks = current_user.tasks.title_search(params[:title_search]).page(params[:page]).per(PER)
      elsif params[:status_search].present?
        @tasks = current_user.tasks.status_search(params[:status_search]).page(params[:page]).per(PER)
      else
        @tasks = current_user.tasks.order_created_desc.page(params[:page]).per(PER)
      end
    elsif params[:sort_priority]
      @tasks = current_user.tasks.order("priority ASC").page(params[:page]).per(PER)
    else
      @tasks = current_user.tasks.order_created_desc.page(params[:page]).per(PER)
    end
  end

  def new
    @task = Task.new
    @task.tasks_labels.build
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
    @labels = @task.labels
  end

  def destroy
    @task.destroy
    redirect_to(tasks_path, notice:"削除しました")
  end

  private
  

  def task_params
    params.require(:task).permit(:title, :content, :expiration_at, :priority, :status, { label_ids: [] })
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def set_labels
    @labels = Label.all
  end

  PER = 5

end
