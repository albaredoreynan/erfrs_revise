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

  def check_dup
    @default_message = params[:message]
    @check_dup = params[:model].camelize.constantize.where(params[:type].intern => "#{params[:content_var]}").present?
  end

  def view_all
    @news_informations = NewsInformation.where("publish_start <= ? and publish_end >= ?", Date.today, Date.today ).recent
  end

end
