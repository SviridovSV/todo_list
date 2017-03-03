class ProjectsController < ApplicationController
  before_action :set_project, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index]

  def index
    @projects ||= current_user.projects.order(id: :desc) 
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @project = Project.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @project = Project.create(project_params)
    @project.user = current_user
    respond_to do |format |
      if @project.save
        flash[:success] = 'Project was successfully created.'
        format.js 
      else
        format.js { render :new }
      end
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render action: 'edit'
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
