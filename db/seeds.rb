require 'csv'

def normalize(region_name)
  if region_name.index '('
    code, name = region_name.split('(')
    [code.strip, name.strip.chop]
  else
    code, name = region_name.split('-')
    [code.strip, name.strip]
  end
end

def region(row)
  @region ||= begin
                code, name = normalize(row['region'])
                Region.find_or_create_by(code: code, name: name)
  end
end

def province(row)
  @province ||= begin
                  name = row['province']
                  region(row).provinces.find_or_create_by(name: name.try(:strip))
                end
end

def municipality(row)
  @municipality ||= begin
                      name = row['city']
                      province(row).municipalities.find_or_create_by(name: name.try(:strip))
                    end
end

def parse_barangay(row)
  name = row['name']
  municipality(row).barangays.find_or_create_by(name: name.try(:strip))
end


file = File.read Rails.root.join('db/seeds/philippine-barangays.csv')
csv = CSV.parse(file, :headers => true)

csv.each do |row|
  puts "parsing #{row['name']}, #{row['city']}"
  parse_barangay(row)
  [:@region, :@province, :@municipality].each &method(:remove_instance_variable)
end

role1 = Role.find_or_create_by(name: 'Admin', code: 0)
role2 = Role.find_or_create_by(name: 'National', code: 10)
role3 = Role.find_or_create_by(name: 'Regional', code: 20)
role4 = Role.find_or_create_by(name: 'Sub Regional', code: 30)
role5 = Role.find_or_create_by(name: 'Municipal', code: 40)
role6 = Role.find_or_create_by(name: 'Barangay', code: 50)
role6 = Role.find_or_create_by(name: 'Public', code: 100)



