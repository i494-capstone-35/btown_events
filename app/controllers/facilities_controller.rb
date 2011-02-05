class FacilitiesController < ApplicationController
  # GET /facilities
  # GET /facilities.xml
  def index
    @facilities = Facility.all
    # expose(:facilities) { Facility.all }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @facilities }
    end
  end

  # GET /facilities/1
  # GET /facilities/1.xml
  def show
    @facility = Facility.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @facility }
    end
  end
end
