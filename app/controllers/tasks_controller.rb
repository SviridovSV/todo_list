class TasksController < ApplicationController
  before_action :current_project

  def create
    task = @project.tasks.new(task_params)
    if task.save
      flash.now[:success] = 'Task was successfully created.'
    else
      flash.now[:error] = 'Something went wrong.'
    end
    redirect_to projects_path
  end

  def edit
    @task = @project.tasks.find(params[:id])
  end

  def update
    @task = current_task
    @task.update(task_params)
  end

  def destroy
    @task = current_task
    if @task.destroy
      flash.now[:success] = 'Task was successfully destroied.'
    else
      flash.now[:error] = 'Something went wrong.'
    end
    redirect_to projects_path
  end

  private

  def current_task
    current_project
    @project.tasks.find(params[:id])
  end

  def current_project
    @project = Project.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:project_id, :name)
  end
end
