class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :landing_page

  def dashboard
  end

  def landing_page
    if current_user
     redirect_to dashboard_path  
    end
  end

  
end
