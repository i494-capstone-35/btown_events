class FacilitiesController < ApplicationController
  def index
    @facilities = Facility.all

    respond_to :html
  end

  def show
    @facility = Facility.find(params[:id])

    respond_to :html
  end
end
