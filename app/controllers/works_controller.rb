class WorksController < ApplicationController
  def index
    if params[:days]
      @works = Work.recentdays(params[:days]).order("datetimeperformed DESC")
    else
      @works = Work.all.order("datetimeperformed DESC")
    end
  end

  def show
    @work = Work.find(params[:id])
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    respond_to do |format|
      if @work.save
        Usermailer.workcreated_email(@work).deliver_now
        format.html { redirect_to @work, notice: "Work Created" }
        format.js { }
      else
        format.html { render "new" }
        format.js { }
      end
    end
  end

  def edit
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id])

    if @work.update(work_params)
      flash[:notice] = "Work Updated"
      redirect_to @work
    else
      render "edit"
    end
  end  

  private
    def work_params
      params.require(:work).permit(:project_id, :user_id, :datetimeperformed, :hours)
    end
end
