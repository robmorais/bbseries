class SeriesController < ApplicationController
  require 'will_paginate/array'

  def index
    @response = ThetvdbClient.token
  end

  def search
    @search_param = params[:series_name]
    @results = ThetvdbClient.search(@search_param).paginate(:page => params[:page], :per_page => 10)
  end

end
