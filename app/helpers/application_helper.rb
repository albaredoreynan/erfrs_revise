module ApplicationHelper

  def active_class(current_controller)
    params[:controller] == current_controller ? "active" : nil
  end

  def trail_id(t, id)
    id.to_s.rjust(t, '0')  
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
  
  def icon_text(icon, text)
    raw("<span class='glyphicon glyphicon-#{icon}'></span> #{text}")
  end

  # CGDPS computation per year and per municipality
  def fund_source(code)
    @fund_source = FundSource.where(code: code).last
    @fund_source.id
  end  

  def budget_allocation(code)
    @fund_source = FundSource.where(code: code).last  
    @budget = FundAllocation.select('amount').where( fund_source_id: @fund_source.id).last
    @budget.amount
  end

  def total_grant_amount_per_mncpl(municipality_id, year, fund_source)
    @total = Array.new
    @val = Subproject.select('grant_amount_direct_cost').where('EXTRACT( YEAR from created_at) = ? AND municipality_id = ? AND fund_source_id = ?', year, municipality_id, fund_source(fund_source))
    @val.each do |amount|
      @total << amount.grant_amount_direct_cost.to_f
    end
    @total.inject(:+)
  end

  def total_grant_amount_per_year(year, fund_source)
    @total = Array.new
    @val = Subproject.select('grant_amount_direct_cost').where('EXTRACT( YEAR from created_at) = ? AND fund_source_id = ?', year, fund_source(fund_source))
    @val.each do |amount|
      @total << amount.grant_amount_direct_cost.to_f
    end
    @total.inject(:+)

  end 

  def total_amount_of_tranches(year, municipality_id)
    @tranch1 = Array.new  
    @tranch2 = Array.new
    @tranch3 = Array.new
    @val = Subproject.select('first_tranch_amount, second_tranch_amount, third_tranch_amount').where('EXTRACT( YEAR from created_at) = ? AND municipality_id = ?', year, municipality_id)
    @val.each do |amount|
      @tranch1 << amount.first_tranch_amount.to_f
      @tranch2 << amount.second_tranch_amount.to_f
      @tranch3 << amount.third_tranch_amount.to_f
    end
    @total = @tranch1.inject(:+) + @tranch2.inject(:+) + @tranch3.inject(:+)
  end

  def cfa_amounts(month, year, municipality_id, code)
    @tranch1 = Array.new
    @tranch2 = Array.new
    @tranch3 = Array.new
    @val = Subproject.select('first_tranch_amount, second_tranch_amount, third_tranch_amount').where('EXTRACT( MONTH from created_at) = ? AND EXTRACT( YEAR from created_at) = ? AND municipality_id = ? AND fund_source_id = ?', month, year, municipality_id, fund_source(code) )
    @val.each do |amount|
      @tranch1 << amount.first_tranch_amount.to_f
      @tranch2 << amount.second_tranch_amount.to_f
      @tranch3 << amount.third_tranch_amount.to_f
    end
    @total = @tranch1.inject(:+).to_f + @tranch2.inject(:+).to_f + @tranch3.inject(:+).to_f
  end

  def total_amount_release(year, fund_source)
    @amount_approve = Array.new
    Subproject.select("id").where('EXTRACT( YEAR from created_at) = ? AND fund_source_id = ?', year, fund_source(fund_source)).each do |sp_id|
      RequestForFundRelease.select("amount_approve").where(subproject_id: sp_id.id).each do |rfrs|
        @amount_approve << rfrs.amount_approve.to_f
      end
    end
    @total = @amount_approve.inject(:+).to_f
  end

  def total_amount_release_per_mncpl(municipality_id, year, fund_source)
    @amount_approve = Array.new
    Subproject.select("id").where('EXTRACT( YEAR from created_at) = ? AND municipality_id = ? AND fund_source_id = ?', year, municipality_id, fund_source(fund_source)).each do |sp_id|
      RequestForFundRelease.select("amount_approve").where(subproject_id: sp_id.id).each do |rfrs|
        @amount_approve << rfrs.amount_approve.to_f
      end
    end
    @total = @amount_approve.inject(:+).to_f
  end

end
