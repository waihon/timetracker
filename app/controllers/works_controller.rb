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
    if params[:doc]
      uploaded_io = params[:doc]
      @work.doc = uploaded_io.original_filename   
      File.open(Rails.root.join("public", "uploads", uploaded_io.original_filename), "wb") do |file|
        file.write(uploaded_io.read)
        @work.doc = uploaded_io.original_filename
      end
    end
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
    
    if params[:doc]
      uploaded_io = params[:doc]
      @work.doc = uploaded_io.original_filename   
      File.open(Rails.root.join("public", "uploads", uploaded_io.original_filename), "wb") do |file|
        file.write(uploaded_io.read)
        @work.doc = uploaded_io.original_filename
      end
    end

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
