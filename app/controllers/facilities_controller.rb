class FacilitiesController < ApplicationController
  def index
    @facilities = Facility.all.sort_by(&:s_name)

    respond_to :html
  end

  def show
    @facility = Facility.find(params[:id])

    respond_to :html
  end
end
