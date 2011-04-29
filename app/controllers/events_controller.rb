class EventsController < ApplicationController

  def increment
    m     = params[:weeks].to_i
    month = params[:month].to_i

    if month != 0
      next_month = ((Date.today + m.weeks).beginning_of_week + month.months).beginning_of_month
      @marker = if next_month.beginning_of_week.month == next_month.month
                  next_month.beginning_of_week
                else
                  (next_month + 1.weeks).beginning_of_week
                end
      # best way to get difference in weeks
      (@marker - Date.today.beginning_of_week).days.inspect =~ /(-?\d+)/
        @m = ($1.to_i / 7)
    else
      @marker = (Date.today + m.weeks).beginning_of_week
      @m      = m
    end

    @week_events = Event.weeks_events(@marker).sort_by(&sort_start_time)
    render 'index.html.haml', :layout => false
  end

  def index
    @marker      = Date.today.beginning_of_week
    @week_events = Event.weeks_events(@marker).sort_by(&sort_start_time)

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
    @events     = Event.where(:date => @today)
    @random     = @events[rand(@events.count)]

    respond_to :html
  end

  private
  def sort_start_time
    Proc.new do |event|
      event.start_time.try(:strftime, "%R") || "0:00" 
    end
  end
end
