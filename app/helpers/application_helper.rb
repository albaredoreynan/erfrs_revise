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
    devise_controller = %w(devise/sessions devise/passwords devise/registrations)
    'clear-container' if devise_controller.include?(controlr)
  end


  
  User.select(:type).distinct.map{|a|a.type}.each do |map|
    define_method("#{map.underscore}_signed_in?") do
      current_user.send("#{map.underscore}?")
    end
  end

  def dropdown_values
    all.map{ |e| [e.name, e.id] }
  end
  
end
