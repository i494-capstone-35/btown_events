class CategoriesController < ApplicationController
  def increment
    n = params[:weeks].to_i
    @category = params[:category]
    @marker = Date.today.beginning_of_week + n.weeks
    @week_events = Event.weeks_events_categories(@marker, @category).sort_by(&sort_start_time)
    render :partial => 'week_box'
  end

  def index
    @categories = Event.all.map(&:category).uniq.sort

    respond_to :html
  end

  def show
    @count = Event.count
    @marker = Date.today.beginning_of_week
    @category = params[:id]
    @week_events = Event.weeks_events_categories(@marker, @category).sort_by(&sort_start_time)

    respond_to :html
  end

  private
  def sort_start_time
    Proc.new do |event|
      event.start_time.try(:strftime, "%R") || "0:00" 
    end
  end
end
