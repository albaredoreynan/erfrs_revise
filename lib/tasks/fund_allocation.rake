# run "rake fund_allocation:import"

namespace :fund_allocation do

  MUNI_COLUMN = {
    name: 'D',
    funds: 'AW'..'BA'
  }
  
  YEAR = {
    'AW' => 2014,
    'AX' => 2015,
    'AY' => 2016,
    'AZ' => 2017,
    'BA' => 2018
  }
  
  task import: :environment do
    open_fund_allocation_file
    @spreadsheet.default_sheet = 'NCDDP 847'

    NOT_MIGRATED = []
    (3..849).each do |row|
      set_municipality(row)
      unless @municipality.present?
        NOT_MIGRATED << "row #{row} - #{cell(row, MUNI_COLUMN[:name])}"
        next
      end
      
      puts "CREATING #{@municipality.name} funds..."
      MUNI_COLUMN[:funds].each do |column|
        create_fund_allocation(row, column)
      end

    end

    puts "*"*60
    puts NOT_MIGRATED
    puts "*"*60
  end

  def open_fund_allocation_file
    @spreadsheet = Roo::Excelx.new('test/fixtures/fund_allocation.xlsx')
  end

  def cell(row, column)
    @spreadsheet.cell(row, column)
  end

  def set_municipality(row)
    # old
    # name = cell(row, MUNI_COLUMN[:name]).upcase
    # new
    name = cell(row, MUNI_COLUMN[:name])

    @municipality = Municipality.find_by(name: name)
  end

  def create_fund_allocation(row, column)
    mfa = @municipality.muni_fund_allocations.build
    mfa.year = YEAR[column]
    amount = cell(row, column)
    mfa.amount = amount.present? ? amount : 0

    puts "***** with YEAR #{mfa.year} and #{mfa.amount}"
    mfa.save
  end

end
