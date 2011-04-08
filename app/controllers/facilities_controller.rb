class FacilitiesController < ApplicationController
  def index
    # sort by name omitting the article
    @facilities = Facility.all.sort_by(&:s_name)
    #@letter_names = @facilities.map { |string| string.chars.to_a.first }.uniq.sort

    respond_to :html
  end

  def show
    @facility = Facility.find(params[:id])

    respond_to :html
  end
end
