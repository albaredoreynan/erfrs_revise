# run "rake signatories:import"

namespace :signatories do

  SHEETS = {
    'OR' => 11..100,
    'DV' => 11..100
  }

  REGION_MAPPING = {
    'I'    => 'REGION I',
    'II'   => 'REGION II',
    'III'  => 'REGION III',
    'IV-A' => 'REGION IV-A',
    'IV-B' => 'REGION IV-B',
    'V'    => 'REGION V',
    'VI'   => 'REGION VI',
    'VII'  => 'REGION VII',
    'VIII' => 'REGION VIII',
    'IX'   => 'REGION IX',
    'X'    => 'REGION X',
    'XI'   => 'REGION XI',
    'XII'  => 'REGION XII',
    'XIII' => 'REGION XIII',
    'NCR'  => 'NCR',
    'CAR'  => 'CAR'
  }

  task import: :environment do
    open_signatories_file

    SHEETS.each do |sheet, rows|
      @spreadsheet.default_sheet = sheet

      rows.each do |row|
        next unless set_region(row)

        initialize_regional_officer
        create_ro_at_box_a(row)

        initialize_regional_officer
        create_ro_at_box_b(row)
      end

    end
  end

  def open_signatories_file
    @spreadsheet = Roo::Excelx.new('test/fixtures/signatories.xlsx')
  end

  def cell(row, column)
    @spreadsheet.cell(row, column)
  end

  def set_region(row)
    code = cell(row, 'B')
    @region_code = code || @region_code
    @region = Region.find_by(code: REGION_MAPPING[@region_code]) rescue false
  end

  def initialize_regional_officer
    @ro = @region.regional_officers.new
    @ro.ro_type = @spreadsheet.default_sheet
  end

  def create_ro_at_box_a(row)
    @ro.name = cell(row, 'C')
    @ro.designation = cell(row, 'D')
    @ro.box = "A" 
    return if missing_ro_fields? || ro_already_exist?

    puts_name_designation
    @ro.save
  end

  def create_ro_at_box_b(row)
    @ro.name = cell(row, 'G')
    @ro.designation = cell(row, 'H')
    @ro.box = "B" 
    return if missing_ro_fields? || ro_already_exist?

    puts_name_designation
    @ro.save
  end

  def missing_ro_fields?
    @ro.name.nil? && @ro.designation.nil?
  end

  def puts_name_designation
    if @ro.name.present? && @ro.designation.present?
      puts "CREATING #{@ro.name} - #{@ro.designation} - #{@ro.box}"
    end
  end

  def ro_already_exist?
    return RegionalOfficer.find_by(name: @ro.name, designation: @ro.designation).present?
  end
end
