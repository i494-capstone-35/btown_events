class CategoriesController < ApplicationController
  def index
    @categories = Event.all.map(&:category).uniq.sort

    respond_to :html
  end

  def show
    #@events = Event.categories(params[:id]).sort_by(&sort_start_time)
    @events = Event.where('date >= ? AND category = ?', Date.today, params[:id])
    @category = @events.first.category
    @weekly_recurring = Event.uniq_by(@events.sort_by(&:date), &:name).sort_by(&sort_start_time)

    respond_to :html
  end

  def sort
    category = CGI.unescape(params[:category])
    @events = Event.where('date >= ? AND category = ?', Date.today, category)
    sort = params[:sortMethod]
    @events = \
      if sort == "start_time"
        @events.sort_by(&sort_start_time)
      else
        @events.sort_by(&sort.to_sym)
      end
    @category = @events.first.category
    @weekly_recurring = Event.uniq_by(@events.sort_by(&:date), &:name)

    render :partial => 'categories'
  end

  private

  def sort_start_time
    Proc.new do |event|
      event.start_time.try(:strftime, "%R") || "0:00" 
    end
  end
end
