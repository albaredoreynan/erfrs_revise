# run "rake barangays:users"

namespace :users do
  
  USER_COLUMN = {
    email: 'A',
    username: 'B',
    password: 'C',
    first_name: 'D',
    last_name: 'E',
    role: 'F',
    region: 'G',
    municipality: 'H',
    province: 'I'
  }
  
  task import: :environment do
  	open_users_list_file
    @spreadsheet.default_sheet = 'Sheet1'

    NOT_MIGRATED = []
    (2..517).each do |row|
      begin
        puts "CREATING row #{row} - #{cell(row, USER_COLUMN[:first_name])}..."
        create_user(row)
      rescue  
        NOT_MIGRATED << "row #{row} - #{cell(row, USER_COLUMN[:first_name])}"
        next
      end
    end

    puts "*"*60
    puts NOT_MIGRATED
    puts "*"*60
  end

  def open_users_list_file
    @spreadsheet = Roo::Excelx.new('test/fixtures/consolidated-users.xlsx')
  end

  def cell(row, column)
    @spreadsheet.cell(row, column)
  end

  def create_user(row)
    user = User.new
    user.email = cell(row, USER_COLUMN[:email])
    user.username = cell(row, USER_COLUMN[:username])
    user.password = cell(row, USER_COLUMN[:password])
    
    user.first_name = cell(row, USER_COLUMN[:first_name]).titleize
    user.last_name = cell(row, USER_COLUMN[:last_name]).titleize
    
    role = cell(row, USER_COLUMN[:role])
    unless role.nil?
      @role = Role.find_or_create_by(code: role.titleize)  
      user.role_id = @role.id
    end
        
    r_code = cell(row, USER_COLUMN[:region])
    unless r_code.nil?
      @region = Region.find_or_create_by(code: r_code)  
      user.region_id = @region.id
    end
    
    p_name = cell(row, USER_COLUMN[:province])
    unless p_name.nil?
      @province = Province.find_or_create_by(name: p_name.titleize)
      user.province_id = @province.id
    end
    
    m_name = cell(row, USER_COLUMN[:municipality])
    unless m_name.nil?
      @municipality = Municipality.find_or_create_by(name: m_name.titleize)
      user.municipality_id = @municipality.id
    end
    
    puts "***** saving #{cell(row, USER_COLUMN[:name])} *****"
    user.save
  end
 
end	