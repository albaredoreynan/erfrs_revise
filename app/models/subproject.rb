class Subproject < ActiveRecord::Base
  belongs_to :region
  belongs_to :province
  belongs_to :municipality
  belongs_to :barangay
  belongs_to :fund_source
  belongs_to :user
  belongs_to :group
  has_many :request_for_fund_releases
  has_many :team_members
  has_many :rfrs, foreign_key: 'request_for_fund_releases_id' ,class_name: "RequestForFundReleases"

  accepts_nested_attributes_for :team_members, reject_if: :reject_team_members

  before_save :check_for_group

  STATUSES = %w{Draft Final}
  CATEGORIES = %w{Category1 Category2}
  PHYSICAL_TARGETS = %w{Target1 Target2}
  COST_PARAMETERS = %w{Parameter1 Parameter2}
  MODES_OF_IMPLEMENTATION = %w{Mode1 Mode2}
  FUND_SOURCES = %w{ADB WB}
  CYCLE = %w{1 2 3 4 5}
  ####################### Validation ########################
  validate :equal_financial_information
  validate :first_tranch_validation
  ####################### SCOPES ###########################
  scope :with_user,   -> username { fetch_all_created_by username }
  scope :with_id,     -> id { where id: id }
  scope :with_status, -> status { where status: status }
  scope :fund_source, -> fs { where fund_source_id: fs}

  if ENV['ERFRS_USES_POSTGRESQL']
    scope :year, -> year { where 'EXTRACT(YEAR FROM date_of_mbif) = ?', year }
  else
    scope :year, -> year { where 'YEAR(date_of_mbif) = ?', year  }
  end

  if ENV['ERFRS_USES_POSTGRESQL']
    scope :with_year, -> year { where 'EXTRACT(YEAR FROM created_at) = ?', year }
  else
    scope :with_year, -> year { where 'YEAR(created_at) = ?', year  }
  end

  %w{region province municipality barangay}.each do |place|
    scope "subproject_#{place}_id".intern, -> place_id { where "#{place}_id" => place_id }
  end

  ####################### END ###########################

  ################# CUSTOM VALIDATION #####################

  def first_tranch_validation
    if self.first_tranch_amount < ((self.grant_amount_direct_cost + self.grant_amount_indirect_cost + self.grant_amount_contingency_cost) * 0.50)
      errors.add(:alert, 'Errors in First Tranch')
    end
  end
  def equal_financial_information
    total_direct = 0
    total_indirect = 0
    total_contingency = 0
    total_lcc_direct = 0
    total_lcc_indirect = 0
    total_lcc_contingency = 0
    %w{lcc_blgu community mlgu plgu_others}.each do |cash|
      total_direct += eval("self.#{cash}_direct_cost")
      total_indirect += eval("self.#{cash}_indirect_cost")
      total_contingency += eval("self.#{cash}_contingency_cost")
    end
    %w{total_lcc_cash total_lcc_in_kind}.each do |cash|
      total_lcc_direct += eval("self.#{cash}_direct_cost")
      total_lcc_indirect += eval("self.#{cash}_indirect_cost")
      total_lcc_contingency += eval("self.#{cash}_contingency_cost")
    end
    if total_direct != total_lcc_direct || total_contingency != total_lcc_contingency || total_lcc_indirect != total_indirect
      errors.add(:alert, 'Financial Information')
    end
  end
  ###################### END ############################
  def check_for_group
    if self.municipality.group.present? 
      self.group_id = self.municipality.group.id
    end
  end

  %i[first second third].each do |nth| 
    method_name = "#{nth}_tranch_date_required"
    define_method(method_name) do
      value = read_attribute(method_name)
      value ? value.to_s(:long)[0..-7] : value
    end
  end


  def total_grant_amount
    return self.grant_amount_direct_cost + self.grant_amount_indirect_cost + self.grant_amount_contingency_cost
  end

  def total_dv_amount
    return self.request_for_fund_releases.sum(:amount_approve)
  end


  private

  def self.fetch_all_created_by(username)
    users = User.where 'username like ?', "%#{username}%"
    users.any? ? where( user_id: users.pluck(:id) ) : none
  end

  def reject_team_members(attributes)
    attributes['name'].blank?
  end


end
