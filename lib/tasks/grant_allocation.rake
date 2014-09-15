# run "rake grant_allocation:import"

namespace :grant_allocation do

  task import: :environment do
    open_grant_allocation_spreadsheet
    @spreadsheet.default_sheet = 'Sheet1'

    ERRORS = []
    (2..848).each do |row|
      begin
        puts "Updating #{cell(row, 'C')}"
        update_municipality_group(row)
      rescue
        ERRORS << "row #{row} - #{cell(row, 'C')}"
        next
      end
    end

    display_error(ERRORS)
  end

  def update_municipality_group(row)
    code = cell(row, 'D').to_i.to_s
    group = Group.find_by(code: code)
    muni = Municipality.find_by(name: cell(row, 'C'))
    muni.update(group_id: group.id)
  end

  def display_error(arr)
    puts "*"*60
    puts arr
    puts "*"*60

    puts "*"*60
    puts "#{arr.count} municiplities NOT MIGRATED."
    puts "*"*60
  end

  def open_grant_allocation_spreadsheet
    @spreadsheet = Roo::Excelx.new('test/fixtures/updated_grant_allocation.xlsx')
  end

  def cell(row, column)
    @spreadsheet.cell(row, column)
  end

end
