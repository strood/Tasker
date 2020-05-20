class TasksController < ApplicationController
  before_action :require_current_user!, except: [:index]
  # Need to deal with restrictions after
  # before_action :require_correct_user!, only: [:edit, :update, :delete]

  def index
    @tasks = Task.all_public_tasks
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
      flash[:notice] = ["Task updated!"]
      if request.referer == edit_task_url(@task)
        redirect_to task_url(@task)
      else
        redirect_to request.referer
      end
    else
      flash[:errors] = @task.errors.full_messages
      render :edit
    end

  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy!
      flash[:notice] = ["Task deleted!"]
      redirect_to request.referer
    else
      flash[:errors] = @task.errors.full_messages
      redirect_to request.referer
    end
  end


  private

  def task_params
    params.require(:task).permit(:title, :description, :private, :completed)
  end
end
