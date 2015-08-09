class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @projects = Project.all
  end

  def show
    if params[:slug]
      @project = Project.find_by slug: params[:slug]
    else
      @project = Project.find(params[:id])
    end
    @work = Work.new
    @work.project = @project
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: "Project Created" }
        format.js { }
      else
        format.html { render "new" }
        format.js { }
      end
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      flash[:notice] = "Project Updated"
      redirect_to @project
    else
      render "edit"
    end
  end

  private
    def project_params
      params.require(:project).permit(:name, :company_id, :default_rate, :slug)
    end
end