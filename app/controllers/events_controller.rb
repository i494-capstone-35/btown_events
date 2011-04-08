class EventsController < ApplicationController
  def increment
    n = params[:weeks].to_i
    @marker = Date.today.beginning_of_week + n.weeks
    @week_events = Event.weeks_events(@marker).sort_by(&:start_time)
    render :partial => 'week_box'
  end

  def index
    @count = Event.count
    @marker = Date.today.beginning_of_week
    @week_events = Event.weeks_events(@marker).sort_by(&:start_time)

    respond_to :html
  end

  def show
    @event = Event.find(params[:id])

    respond_to :html
  end

  def date
    unless params[:year].nil?
      @today = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    else
      @today = Date.today
    end
    @categories = Event.all.map(&:category).uniq.sort
    @events = Event.where(:date => @today)
    @random = @events[rand(@events.count)]

    respond_to :html
  end
end
