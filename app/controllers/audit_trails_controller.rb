class AuditTrailsController < ApplicationController
  def index
      @activities = PublicActivity::Activity.order("created_at desc").paginate(page: params[:page], per_page: 30)
  end
end
