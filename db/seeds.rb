require 'csv'

def region(row)
  @region ||= begin
                code, name = row['region'].split('-')
                Region.find_or_create_by(code: code.strip, name: name.strip)
              end
end

def province(row)
  @province ||= begin
                  name = row['province']
                  region(row).provinces.find_or_create_by(name: name.strip)
                end
end

def municipality(row)
  @municipality ||= begin
                      name = row['city']
                      province(row).municipalities.find_or_create_by(name: name.strip)
                    end
end

def parse_barangay(row)
  name = row['name']
  municipality(row).barangays.find_or_create_by(name: name.strip)
end


file = File.read Rails.root.join('db/seeds/philippine-barangays.csv')
csv = CSV.parse(file, :headers => true)

csv.each do |row|
  puts "parsing #{row['name']}, #{row['city']}"
  parse_barangay(row)
  [:@region, :@province, :@municipality].each &method(:remove_instance_variable)
end


