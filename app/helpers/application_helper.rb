module ApplicationHelper

  def active_class(current_controller)
    params[:controller] == current_controller ? "active" : nil
  end

  def flash_class(level)
    case level
      when :notice  then "alert alert-info"
      when :success then "alert alert-success"
      when :error   then "alert alert-danger"
      when :alert   then "alert alert-warning"
    end
  end

  def devise_layout(controlr)
    'clear-container' if controlr == 'devise/sessions'
  end

end
