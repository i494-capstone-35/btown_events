class FacilitiesController < ApplicationController
  def index
    # sort by name omitting the article
    @facilities = Facility.all.sort_by(&:s_name)

    respond_to :html
  end

  def show
    @facility = Facility.find(params[:id])

    respond_to :html
  end
end
