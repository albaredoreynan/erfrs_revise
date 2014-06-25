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
  before_validation :add_date_encoded

  STATUSES = %w{Draft Final}
  CATEGORIES = %w{Category1 Category2}
  PHYSICAL_TARGETS = %w{Target1 Target2}
  COST_PARAMETERS = %w{Parameter1 Parameter2}
  MODES_OF_IMPLEMENTATION = %w{Mode1 Mode2}
  FUND_SOURCES = %w{ADB WB}
  CYCLE = %w{1 2 3 4 5}
  ####################### Validation ########################
  validate :equal_financial_information, :on => :create
  validate :first_tranch_validation, :on => :create
  validates :region_id, :municipality_id, :province_id, :barangay_id, 
            :title, :date_of_mibf, :cycle, :date_encoded, presence: true


  validates :grant_amount_direct_cost, :grant_amount_indirect_cost, :grant_amount_contingency_cost,
            :lcc_blgu_direct_cost, :lcc_blgu_indirect_cost, :lcc_blgu_contingency_cost, :community_direct_cost,
            :community_indirect_cost, :community_contingency_cost, :mlgu_direct_cost, :mlgu_indirect_cost, :mlgu_contingency_cost,
            :plgu_others_direct_cost, :plgu_others_indirect_cost, :plgu_others_contingency_cost, :total_lcc_cash_direct_cost, :total_lcc_cash_indirect_cost,
            :total_lcc_cash_contingency_cost, :total_lcc_in_kind_direct_cost, :total_lcc_in_kind_indirect_cost, :total_lcc_in_kind_contingency_cost,
            numericality:{ greater_than_or_equal_to: 0, :message => "error: enter proper amount" } 

  validates :grant_amount_direct_cost, :grant_amount_indirect_cost, :grant_amount_contingency_cost,
            :lcc_blgu_direct_cost, :lcc_blgu_indirect_cost, :lcc_blgu_contingency_cost, :community_direct_cost,
            :community_indirect_cost, :community_contingency_cost, :mlgu_direct_cost, :mlgu_indirect_cost, :mlgu_contingency_cost,
            :plgu_others_direct_cost, :plgu_others_indirect_cost, :plgu_others_contingency_cost, :total_lcc_cash_direct_cost, :total_lcc_cash_indirect_cost,
            :total_lcc_cash_contingency_cost, :total_lcc_in_kind_direct_cost, :total_lcc_in_kind_indirect_cost, :total_lcc_in_kind_contingency_cost,
            :first_tranch_amount, :first_tranch_date_required, :second_tranch_amount, :second_tranch_date_required, :third_tranch_amount, :third_tranch_date_required, 
            presence: {:message => 'because you are changing the status to Final'}, :if => ->{ self.status == 'Final' }  
  validates :first_tranch_amount, :second_tranch_amount, :third_tranch_amount, numericality: {greater_than_or_equal_to: 0, message: "error: enter proper amount"}
  validates :first_tranch_date_required, presence: true, :if => -> {self.first_tranch_amount.present?}
  validates :second_tranch_date_required, presence: true, :if => -> {self.second_tranch_amount.present?}
  validates :third_tranch_date_required, presence: true, :if => -> {self.third_tranch_amount.present?}

  validate :mbif_date

  # validates :team_members, associated: {:message => "Team Members Missing"}, :if => -> {self.status == "Final"}
  ####################### SCOPES ###########################
  scope :with_user,   -> username { fetch_all_created_by username }
  scope :with_id,     -> id { where id: id }
  scope :with_status, -> status { where status: status }
  scope :fund_source, -> fs { where fund_source_id: fs}


  # if ENV['ERFRS_USES_POSTGRESQL']
  scope :year, -> year { where 'EXTRACT(YEAR FROM date_of_mibf) = ?', year }
  # else
  #   scope :year, -> year { where 'YEAR(date_of_mibf) = ?', year  }
  # end

  # if ENV['ERFRS_USES_POSTGRESQL']
  scope :with_year, -> year { where 'EXTRACT(YEAR FROM date_of_mibf) = ?', year }
  # else
  #   scope :with_year, -> year { where 'YEAR(created_at) = ?', year  }
  # end

  # if ENV['ERFRS_USES_POSTGRESQL']
  scope :start_date, -> date { where 'date_of_mibf >= ?', date.to_date }
  # else
  #   scope :start_date, -> date { where 'DATE(date_of_mibf) >= ?', date  }
  # end

  # if ENV['ERFRS_USES_POSTGRESQL']
  scope :end_date, -> date { where ' date_of_mibf <= ?', date.to_date }
  # else
  #   scope :end_date, -> date { where 'DATE(date_of_mibf) <= ?', date.to_date    }
  # end

  %w{region province municipality barangay}.each do |place|
    scope "subproject_#{place}_id".intern, -> place_id { where "#{place}_id" => place_id }
  end

  ####################### END ###########################

  ################# CUSTOM VALIDATION #####################

  def add_date_encoded
    self.date_encoded = DateTime.now.to_date
  end
  
  def mbif_date
    if self.date_of_mibf.present?
      errors.add(:error, 'Wrong MBIF Date Input' ) unless self.date_of_mibf.is_a?(Date)
    end
  end

  def first_tranch_validation
    if self.first_tranch_amount < ((self.grant_amount_direct_cost + self.grant_amount_indirect_cost + self.grant_amount_contingency_cost) * 0.50)
      errors.add(:first, ' Tranch must be atleast 50%')
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
      errors.add(:message, 'Wrong Inputs in Financial Information')
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
