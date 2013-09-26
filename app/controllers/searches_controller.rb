class SearchesController < ApplicationController
  def search
    @results = Searchable.search params[:query]
    puts @results
    render :index
  end

  def index
  end

end