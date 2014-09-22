# run "rake barangays:import"

namespace :barangays do
  
  BARANGAY_COLUMN = {
    region: 'A',
    province: 'B',
    municipality: 'C',
    name: 'D',
    nscb_code: 'E'
  }
  
  task import: :environment do
  	open_barangay_list_file
    @spreadsheet.default_sheet = 'Sheet1'

    NOT_MIGRATED = []
    (2..19648).each do |row|
      set_barangay(row)
      unless @municipality.present?
        NOT_MIGRATED << "row #{row} - #{cell(row, BARANGAY_COLUMN[:name])}"
        next
      end
      
      puts "CREATING #{cell(row, BARANGAY_COLUMN[:name])}..."
      create_barangay(row)
    end

    puts "*"*60
    puts NOT_MIGRATED
    puts "*"*60

    puts "*"*60
    puts "updating region names"
    update_region
  end

  def open_barangay_list_file
    @spreadsheet = Roo::Excelx.new('test/fixtures/barangays-n.xlsx')
  end

  def cell(row, column)
    @spreadsheet.cell(row, column)
  end

  def set_barangay(row)

    r_code, name = cell(row, BARANGAY_COLUMN[:region])
    @region = Region.find_or_create_by(code: r_code, name: name)

    p_name = cell(row, BARANGAY_COLUMN[:province])
    @province = @region.provinces.find_or_create_by(name: p_name)

    m_name = cell(row, BARANGAY_COLUMN[:municipality])
    @municipality = @province.municipalities.find_or_create_by(name: m_name)
    @municipality
  end	

  def create_barangay(row)
    barangay = @municipality.barangays.build
    barangay.municipality_id = @municipality.id
    barangay.name = cell(row, BARANGAY_COLUMN[:name])
    barangay.nscb_code = cell(row, BARANGAY_COLUMN[:nscb_code])

    puts "***** saving #{cell(row, BARANGAY_COLUMN[:name])}*****"
    barangay.save
  end
 
  def update_region
    car = Region.find_by(code: 'CAR')
    car.update_attributes(name: 'Cordillera Administrative Region') unless car.nil?

    one = Region.find_by(code: 'I')
    one.update_attributes(name: 'Ilocos Region') unless one.nil?

    three = Region.find_by(code: 'III')
    three.update_attributes(name: 'Central Luzon') unless three.nil?

    four_a = Region.find_by(code: 'IV-A')
    four_a.update_attributes(name: 'Calabarzon') unless four_a.nil?

    four_b = Region.find_by(code: 'IV-B')
    four_b.update_attributes(name: 'Mimaropa') unless four_b.nil?

    five = Region.find_by(code: 'V')
    five.update_attributes(name: 'Bicol Region') unless five.nil?

    six = Region.find_by(code: 'VI')
    six.update_attributes(name: 'Western Visayas') unless six.nil?

    seven = Region.find_by(code: 'VII')
    seven.update_attributes(name: 'Central Visayas') unless seven.nil?

    eight = Region.find_by(code: 'VIII')
    eight.update_attributes(name: 'Eastern Visayas') unless eight.nil?

    nine = Region.find_by(code: 'IX')
    nine.update_attributes(name: 'Zamboanga Peninsula') unless nine.nil?

    ten = Region.find_by(code: 'X')
    ten.update_attributes(name: 'Northern Mindanao') unless ten.nil?

    eleven = Region.find_by(code: 'XI')
    eleven.update_attributes(name: 'Davao Region') unless eleven.nil?

    twelve = Region.find_by(code: 'XII')
    twelve.update_attributes(name: 'Soccsksargen') unless twelve.nil?

    thirteen = Region.find_by(code: 'Caraga')
    thirteen.update_attributes(code: 'XIII', name: 'Caraga') unless thirteen.nil?
  end

end	