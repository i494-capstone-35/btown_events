class EventsController < ApplicationController
  def increment
    n = params[:weeks].to_i
    @marker = Date.today.beginning_of_week + n.weeks
    @week_events = Event.weeks_events @marker
    render :partial => 'week_box'
  end

  def index
    @events = Event.all
    @count = Event.count
    @marker = Date.today.beginning_of_week
    @week_events = Event.weeks_events @marker
    
    respond_to :html
  end

  def show
    @event = Event.find(params[:id])

    respond_to :html
  end

  def month
    @events = Event.all
    @count = Event.count
    @marker = Date.today.beginning_of_month.beginning_of_week
    @weeks = (Time.days_in_month Date.current.month) / 7
    @extras = (Time.days_in_month Date.current.month) % 7
    @days = 7
    @week_events = Event.weeks_events @marker

    respond_to :html
  end
end
