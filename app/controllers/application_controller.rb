class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def user_for_paper_trail
    user_signed_in? ? current_user.full_name : 'Public'  # or whatever
  end
end
