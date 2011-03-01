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

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  def categories
    @categories = Event.all.map(&:category).uniq.sort

    respond_to do |format|
      format.html
    end
  end
end
