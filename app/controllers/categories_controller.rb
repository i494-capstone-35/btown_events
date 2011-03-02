class CategoriesController < ApplicationController
  
  def index
    @categories = Event.all.map(&:category).uniq.sort

    respond_to :html
  end

  def show
    @category = Event.categories params[:id]

    respond_to :html
  end
end
