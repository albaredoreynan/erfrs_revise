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

    (3..849).each do |row|
      set_municipality(row)
      next unless @municipality.present?      
      
      puts "CREATING #{@municipality.name} funds..."
      MUNI_COLUMN[:funds].each do |column|
        create_fund_allocation(row, column)
      end

    end
  end

  def open_fund_allocation_file
    @spreadsheet = Roo::Excelx.new('test/fixtures/fund_allocation.xlsx')
  end

  def cell(row, column)
    @spreadsheet.cell(row, column)
  end

  def set_municipality(row)
    name = cell(row, MUNI_COLUMN[:name]).upcase
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
