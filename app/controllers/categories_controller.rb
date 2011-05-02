class CategoriesController < ApplicationController
  def images
    @categories = Event.all.map(&:category).uniq.sort
    @image_names = @categories.map {|c| c.gsub(/\s*/,'')}

    render :json => @image_names
  end

  def increment
    m         = params[:weeks].to_i
    @category = params[:category]
    month     = params[:month].to_i

    if month != 0
      next_month = (Date.today + m.weeks).beginning_of_week + month.months
      if next_month.beginning_of_month.beginning_of_week.month == next_month.beginning_of_month.month
        @marker = next_month.beginning_of_month.beginning_of_week
      else
        @marker = (next_month.beginning_of_month + 1.weeks).beginning_of_week
      end
      # best way to get difference in weeks
      (@marker - Date.today.beginning_of_week).days.inspect =~ /(-?\d+)/
        @m = ($1.to_i / 7)
    else
      @marker = (Date.today + m.weeks).beginning_of_week
      @m      = m
    end

    @week_events = Event.weeks_events_categories(@marker, @category).sort_by(&sort_start_time)
    render 'show.html.haml', :layout => false
  end


  def index
    @categories = Event.all.map(&:category).uniq.sort

    respond_to :html
  end

  def show
    @marker      = Date.today.beginning_of_week
    @category    = params[:id]
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
