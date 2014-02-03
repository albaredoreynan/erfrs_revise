class StaticPagesController < ApplicationController
  skip_before_action :authenticate_super_user!

  def home
  end

  def dashboard
  end
end
