# run "rake muni_group_id:import"

namespace :muni_group_id do

  GROUP = {
    "293" => 1,
    "177" => 2,
    "377" => 3
  }

  task import: :environment do
    open_fund_allocation
    @spreadsheet.default_sheet = 'NCDDP 847'

    NOT_MIGRATED = []
    (3..849).each do |row|
      update_municipality_group(row)
    end

    puts "*"*60
    puts NOT_MIGRATED
    puts "*"*60
  end

  def open_fund_allocation
    @spreadsheet = Roo::Excelx.new('test/fixtures/fund_allocation.xlsx')
  end

  def cell(row, column)
    @spreadsheet.cell(row, column)
  end

  def update_municipality_group(row)
    name = cell(row, MUNI_COLUMN[:name])
    @municipality = Municipality.where("name ILIKE ?", name).first

    unless @municipality.present?
      NOT_MIGRATED << "row #{row} - #{cell(row, MUNI_COLUMN[:name])}"
      return
    end
      
    group_id = GROUP[cell(row, 'AM').to_s.split('.').first]
    puts "UPDATING #{@municipality.name} with group_id #{group_id}"
    @municipality.update(group_id: group_id)
  end

end
