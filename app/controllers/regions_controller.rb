class RegionsController < ApplicationController
  respond_to :html, :json

  def index
    @regions = Region.all
    respond_with @regions
  end
end
