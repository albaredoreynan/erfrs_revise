class CgdpsController < ApplicationController

  def index
    @search = Subproject.search(params[:q])
    @subprojects = @search.result
  end

end
