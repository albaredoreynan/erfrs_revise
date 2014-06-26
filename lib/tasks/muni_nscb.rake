# run "rake muni_nscb:import"

namespace :muni_nscb do

  task import: :environment do
    open_ndrrmc
    @spreadsheet.default_sheet = 'NDRRMC Earthquake affected'

    NOT_MIGRATED = []
    (2..71).each do |row|
      set_spreadshet_values(row)
      begin
        barangays = municipality.barangays
        puts "Importing NSCB code to all barangays of #{@municipality}"
        barangays.each do |barangay|
          barangay.update(nscb_code: @nscb_code)
        end
        puts ".....SUCCESS! #{barangays.count} barangays were imported."
      rescue
        NOT_MIGRATED << row
        next
      end
    end

    puts "*"*60
    puts NOT_MIGRATED
    puts "*"*60
  end

  def open_ndrrmc
    @spreadsheet = Roo::Excelx.new('test/fixtures/fund_allocation.xlsx')
  end

  def cell(row, column)
    @spreadsheet.cell(row, column)
  end

  def set_spreadshet_values(row)
    @region = "REGION #{cell(row, 'A')}"
    @province = cell(row, 'B').upcase
    @municipality = cell(row, 'C').upcase
    @nscb_code = cell(row, 'D').upcase
  end

  def find_municipality(row)
    region(row)
  end

  def region
    Region.find_by(code: @region)
  end

  def province
    region.provinces.find_by(name: @province)
  end

  def municipality
    province.municipalities.where("name ILIKE ?", @municipality).first
  end

end
