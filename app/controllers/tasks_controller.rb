class TasksController < ApplicationController
  before_action :current_project
  before_action :current_task, only: [:edit, :up_priority, :down_priority]

  def create
    @task = @project.tasks.create(task_params)
    @task.set_priority
    if @task.save
      flash.now[:success] = 'Task was successfully created.'
    else
      flash.now[:error] = 'Something went wrong.'
    end
    redirect_to projects_path
  end

  def edit
  end

  def update
    @task = current_task
    if @task.update(task_params)
      flash.now[:success] = 'Task was successfully updated.'
      redirect_to projects_path
    else
      flash.now[:error] = 'Something went wrong.'
      render 'edit'
    end
  end

  def destroy
    @task = current_task
    if @task.destroy
      @task.update_priority
      flash.now[:success] = 'Task was successfully destroied.'
    else
      flash.now[:error] = 'Something went wrong.'
    end
    redirect_to projects_path
  end

  def up_priority
    @task.up_prior
    redirect_to projects_path
  end

  def down_priority
    @task.down_prior
    redirect_to projects_path
  end

  private

  def current_task
    @task = @project.tasks.find(params[:id])
  end

  def current_project
    @project = Project.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:project_id, :name, :status, :deadline)
  end
end
