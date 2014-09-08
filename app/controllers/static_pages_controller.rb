class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :landing_page

  def dashboard
    @news_informations = NewsInformation.where("publish_start <= ? and publish_end >= ?", Date.today, Date.today ).recent
  end

  def landing_page
    if current_user
      redirect_to dashboard_path  
    end
  end


end
