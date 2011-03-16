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
    puts @category.count
    sort = params[:sortMethod]
    @category = @category.sort_by(&sort.to_sym)
    puts @category.count
    render :partial => 'categories'
  end
end
