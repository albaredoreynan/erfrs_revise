module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

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
    if map.present?
      define_method("#{map.underscore}_signed_in?") do
        current_user.send("#{map.underscore}?")
      end
    end
  end

  def dropdown_values
    all.map{ |e| [e.name, e.id] }
  end
  
  def icon_text(icon, text)
    raw("<span class='glyphicon glyphicon-#{icon}'></span> #{text}")
  end

  # CGDPS computation per year and per municipality
  # def fund_source(code)
  #   @fund_source = FundSource.where(code: code).last
  #   @fund_source.id
  # end  

  def budget_allocation(code, year)
    @budget = FundAllocation.select('amount').where( fund_source_id: code, year: year).last
    if @budget.nil?
      @budget = 0
    else  
      @budget.amount
    end
  end

  def budget_allocation_per_mun(code, year, municipality_id)
    @budget = MuniFundAllocation.select('amount').where( municipality_id: municipality_id, year: year).last
    if @budget.nil?
      @budget = 0
    else  
      @budget.amount
    end  
  end

  def total_grant_amount_per_mncpl(municipality_id, year, fund_source)
    @total = Array.new
    @val = Subproject.select('grant_amount_direct_cost').where('EXTRACT( YEAR from created_at) = ? AND municipality_id = ? AND fund_source_id = ?', year, municipality_id, fund_source)
    @val.each do |amount|
      @total << amount.grant_amount_direct_cost.to_f
    end
    @total.inject(:+)
  end

  def total_grant_amount_per_year(year, fund_source)
    @total = Array.new
    @val = Subproject.select('grant_amount_direct_cost').where('EXTRACT( YEAR from created_at) = ? AND fund_source_id = ?', year, fund_source)
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

    @val1 = Subproject.select('first_tranch_amount').where('EXTRACT( MONTH from first_tranch_date_required) = ? AND EXTRACT( YEAR from first_tranch_date_required) = ? AND municipality_id = ? AND fund_source_id = ?', month, year, municipality_id, code)
    @val1.each do |amount|
      @tranch1 << amount.first_tranch_amount.to_f
    end

    @val2 = Subproject.select('second_tranch_amount').where('EXTRACT( MONTH from second_tranch_date_required) = ? AND EXTRACT( YEAR from second_tranch_date_required) = ? AND municipality_id = ? AND fund_source_id = ?', month, year, municipality_id, code)
    @val2.each do |amount|
      @tranch2 << amount.second_tranch_amount.to_f
    end

    @val3 = Subproject.select('third_tranch_amount').where('EXTRACT( MONTH from third_tranch_date_required) = ? AND EXTRACT( YEAR from third_tranch_date_required) = ? AND municipality_id = ? AND fund_source_id = ?', month, year, municipality_id, code)
    @val3.each do |amount|
      @tranch3 << amount.third_tranch_amount.to_f
    end

    @total = @tranch1.inject(:+).to_f + @tranch2.inject(:+).to_f + @tranch3.inject(:+).to_f
  end
  
  def earliest_month(year, municipality_id)
    @month = Subproject.select('first_tranch_date_required').where('EXTRACT( YEAR from date_of_mibf) = ? AND municipality_id = ? AND fund_source_id = ? OR fund_source_id = ?', year, municipality_id, 1, 2).order("first_tranch_date_required").first
    if @month.nil?
      DateTime.now.beginning_of_year
    else  
      @month.first_tranch_date_required
    end
  end

  def total_amount_release(year, fund_source)
    @amount_approve = Array.new
    Subproject.select("id").where('EXTRACT( YEAR from created_at) = ? AND fund_source_id = ?', year, fund_source).each do |sp_id|
      RequestForFundRelease.select("amount_approve").where(subproject_id: sp_id.id).each do |rfrs|
        @amount_approve << rfrs.amount_approve.to_f
      end
    end
    @total = @amount_approve.inject(:+).to_f
  end

  def total_amount_release_per_mncpl(municipality_id, year, fund_source)
    @amount_approve = Array.new
    Subproject.select("id").where('EXTRACT( YEAR from created_at) = ? AND municipality_id = ? AND fund_source_id = ?', year, municipality_id, fund_source).each do |sp_id|
      RequestForFundRelease.select("amount_approve").where(subproject_id: sp_id.id).each do |rfrs|
        @amount_approve << rfrs.amount_approve.to_f
      end
    end
    @total = @amount_approve.inject(:+).to_f
  end

  def initial_tranch_per_month(sps, year)

    data_f = [[],[],[],[],[],[],[],[],[],[],[],[]]
    sps.each do |a|
      if a.first_tranch_date_required.present? and a.first_tranch_date_required.to_time.strftime("%Y") == year.to_s
        %i(January Febuary March April May June July August September October November December).each_with_index do |month, index|
          if a.first_tranch_date_required.to_time.strftime("%B") == month.to_s
            data_f[index] << a.first_tranch_amount        
            #condition if revised amount present
          end
        end 
      end

      if a.second_tranch_date_required.present?
        if a.second_tranch_date_required.to_time.strftime("%Y") == year.to_s 
          %i(January Febuary March April May June July August September October November December).each_with_index do |month, index|
            if a.second_tranch_date_required.to_time.strftime("%B") == month.to_s
              data_f[index] << a.second_tranch_amount      
            end
          end
        else
          %i(January Febuary March April May June July August September October November December).each_with_index do |month, index|
            if a.second_tranch_date_required.to_time.strftime("%B") == month.to_s
              data_f[index] << "#{number_to_currency a.second_tranch_amount}(#{a.second_tranch_date_required.to_time.strftime("%Y")})"      
            end
          end
        end
      end

      if a.third_tranch_date_required.present?
        if a.third_tranch_date_required.to_time.strftime("%Y") == year.to_s
          %i(January Febuary March April May June July August September October November December).each_with_index do |month, index|
            if a.third_tranch_date_required.to_time.strftime("%B") == month.to_s
              data_f[index] << a.third_tranch_amount      
            end
          end
        else
          %i(January Febuary March April May June July August September October November December).each_with_index do |month, index|
            if a.third_tranch_date_required.to_time.strftime("%B") == month.to_s
              data_f[index] << "#{number_to_currency a.third_tranch_amount}(#{a.third_tranch_date_required.to_time.strftime("%Y")})"    
            end
          end
        end 
      end
    end
    data_f
  end



  def revised_tranch_per_month(sps, year)

    data_f = [[],[],[],[],[],[],[],[],[],[],[],[]]
    sps.each do |a|
      if a.first_tranch_date_required.present? and a.first_tranch_date_required.to_time.strftime("%Y") == year.to_s
        %i(January February March April May June July August September October November December).each_with_index do |month, index|
          if a.first_tranch_date_required.to_time.strftime("%B") == month.to_s
            data_f[index] << a.first_tranch_revised_amount        
            #condition if revised amount present first_tranch_revised_amount
          end
        end 
      end

      if a.second_tranch_date_required.present? and a.second_tranch_date_required.to_time.strftime("%Y") == year.to_s
        %i(January February March April May June July August September October November December).each_with_index do |month, index|
          if a.second_tranch_date_required.to_time.strftime("%B") == month.to_s
            data_f[index] << a.second_tranch_revised_amount      

          end
        end 
      end

      if a.third_tranch_date_required.present? and a.third_tranch_date_required.to_time.strftime("%Y") == year.to_s
        %i(January February March April May June July August September October November December).each_with_index do |month, index|
          if a.third_tranch_date_required.to_time.strftime("%B") == month.to_s
            data_f[index] << a.third_tranch_revised_amount      
          end
        end 
      end
    end
    data_f
  end

  def team_member_name(id)
    if id.nil?
      @tm = ''
    else
      @tm = TeamMember.find(id)
      @tm.name
    end
  end

  def regional_officer(region_id, box, ro_type)
    @position = RegionalOfficer.select("id, designation, name").where("region_id = ? AND box = ? AND ro_type = ?", region_id, box, ro_type)
  end

############################## Encryptor ################################

  def cipher
    OpenSSL::Cipher::Cipher.new('aes-256-cbc')
  end
 
  def cipher_key
    'any string that you want'
  end
 
  def deobfuscate(value)
    c = cipher.decrypt
    c.key = Digest::SHA256.digest(cipher_key)
    c.update(Base64.decode64(value.to_s)) + c.final
  end
 
  def obfuscate(value)
    c = cipher.encrypt
    c.key = Digest::SHA256.digest(cipher_key)
    Base64.encode64(c.update(value.to_s) + c.final).squish
  end
##########################################################################
end
