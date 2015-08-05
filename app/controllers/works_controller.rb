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
end
