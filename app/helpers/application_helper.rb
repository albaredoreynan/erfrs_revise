module ApplicationHelper

  def active_class(current_controller)
    params[:controller] == current_controller ? "active" : nil
  end

end
