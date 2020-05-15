class TasksController < ApplicationController
  before_action :require_current_user!

  def index
    @tasks = current_user.tasks
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      flash[:notice] = ["Task Saved!"]
      redirect_to task_url(@task)
    else
      flash[:errors] = @task.errors.full_messages
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
    render :edit
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:notice] = ["Task updated"]
      if request.referer == edit_task_url(@task)
        redirect_to @task
      else
        redirect_to request.referer
      end
    else
      flash[:errors] = @task.errors.full_messages
      render :edit
    end

  end


  private

  def task_params
    params.require(:task).permit(:title, :description, :private, :completed)
  end
end
