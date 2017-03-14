class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, except: [:index, :new, :create]
  

  def index
    @projects = current_user.projects.paginate(page: params[:page], per_page: 2)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    if @project.save
      flash[:success] = 'Project was successfully created.'
      redirect_to root_url
    else
      render :new 
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      flash[:success] = 'Project was successfully updated.'
      redirect_to root_url 
    else
      render action: 'edit'
    end
  end

  def destroy
    @project.destroy
    @projects = current_user.projects
    flash[:success] = 'Project was successfully destroyed.'
    redirect_to projects_url
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
