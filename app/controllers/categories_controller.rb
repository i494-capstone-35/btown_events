class CategoriesController < ApplicationController
  def index
    @categories = Event.all.map(&:category).uniq.sort

    respond_to :html
  end

  def show
    @category = Event.categories params[:id]

    respond_to :html
  end

  def sort
    @category = Event.categories(CGI.unescape params[:category])
    sort = params[:sortMethod]
    @category = @category.sort_by(&sort.to_sym)
    render :partial => 'categories'
  end
end
