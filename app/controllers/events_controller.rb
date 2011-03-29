class EventsController < ApplicationController
  def increment
    n = params[:weeks].to_i
    @marker = Date.today.beginning_of_week + n.weeks
    @week_events = Event.weeks_events(@marker).sort_by(&:start_time)
    render :partial => 'week_box'
  end

  def date
    n = params[:date].to_i
    @today = Date.today + n.days
    @categories = Event.all.map(&:category).uniq.sort
    render :index
  end

  def index
    @count = Event.count
    @marker = Date.today.beginning_of_week
    @week_events = Event.weeks_events(@marker).sort_by(&:start_time)

    @today = Date.today
    @mobile_marker = 0
    @categories = Event.all.map(&:category).uniq.sort

    respond_to :html
  end

  def show
    @event = Event.find(params[:id])

    respond_to :html
  end

  def month
    @count = Event.count
    @marker = Date.today.beginning_of_month.beginning_of_week
    @month_marker = Date.today.beginning_of_month
    @weeks = (Time.days_in_month Date.current.month) / 7
    @extras = (Time.days_in_month Date.current.month) % 7
    @week_events = Event.weeks_events @marker

    respond_to :html
  end
end
