require 'csv'
PublicActivity.enabled = false
# def normalize(region_name)
#   if region_name.index '('
#     code, name = region_name.split('(')
#     [code.strip, name.strip.chop]
#   else
#     code, name = region_name.split('-')
#     [code.strip, name.strip]
#   end
# end

# def region(row)
#   @region ||= begin
#                 code, name = normalize(row['region'])
#                 Region.find_or_create_by(code: code, name: name)
#   end
# end

# def province(row)
#   @province ||= begin
#                   name = row['province']
#                   region(row).provinces.find_or_create_by(name: name.try(:strip))
#                 end
# end

# def municipality(row)
#   @municipality ||= begin
#                       name = row['city']
#                       province(row).municipalities.find_or_create_by(name: name.try(:strip))
#                     end
# end

# def parse_barangay(row)
#   name = row['name']
#   municipality(row).barangays.find_or_create_by(name: name.try(:strip))
# end


# file = File.read Rails.root.join('db/seeds/philippine-barangays.csv')
# csv = CSV.parse(file, :headers => true)

# csv.each do |row|
#   puts "parsing #{row['name']}, #{row['city']}"
#   parse_barangay(row)
#   [:@region, :@province, :@municipality].each &method(:remove_instance_variable)
# end

puts "Roles List"
role1 = Role.find_or_create_by(name: 'Admin', code: 0)
role2 = Role.find_or_create_by(name: 'National', code: 10)
role3 = Role.find_or_create_by(name: 'Regional Admin', code: 15)
role3 = Role.find_or_create_by(name: 'Regional', code: 20)
role5 = Role.find_or_create_by(name: 'Municipal', code: 40)
role6 = Role.find_or_create_by(name: 'Barangay', code: 50)
role6 = Role.find_or_create_by(name: 'Public', code: 100)
puts "Done!!"

# puts "Users List"
# User.find_or_create_by_username(username: 'adminuser', first_name: 'Administrator', last_name: 'User', email: 'admin@appsource.biz', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'erwinlopez', first_name: 'Erwin', last_name: 'Lopez', email: 'erwinlopez2636@gmail.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'jcardino', first_name: 'Jonalyn', last_name: 'Cardino', email: 'john_dai.h8lona@yahoo.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'lanas', first_name: 'Loudie Joye', last_name: 'Anas', email: 'loudicejoyce@gmail.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'ralcosjr', first_name: 'Rodulfo', last_name: 'Alcos Jr.', email: 'alcosjr.rodulfo@yahoo.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'jpuaben', first_name: 'Joan', last_name: 'Puaben', email: 'joan_puaben@yahoo.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'mgalagala', first_name: 'Melanie', last_name: 'Galagala', email: 'melaniegalagala@gmail.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'agarcia', first_name: 'Aurora', last_name: 'Garcia', email: 'garciaaurora96@gmail.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'jitim', first_name: 'Jocelyn', last_name: 'Itim', email: 'jocelynitim@yahoo.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'mvilla', first_name: 'Mary Jane', last_name: 'Villa', email: 'mjonyxv7@gmail.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'ddimalao', first_name: 'Danny', last_name: 'Dimalao', email: 'fapamana12@gmail.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'mangcos', first_name: 'Mary Jane', last_name: 'Angcos', email: 'kcncddsurigao@gmail.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'ygambin', first_name: 'Yeelyn', last_name: 'Gambin', email: 'kcfa2caraga@gmail.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'jancla', first_name: 'John Voltaire', last_name: 'Ancla', email: 'kc.rfa.caraga@gmail.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'kmanlapaz', first_name: 'Kristianne', last_name: 'Manlapaz', email: 'kristian_manlapaz@yahoo.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'avillanueva', first_name: 'Angeli Lou', last_name: 'Villanueva', email: 'aljvillanueva.cpa@gmail.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'mflores', first_name: 'Ma. Melody', last_name: 'Flores', email: 'may_odio@yahoo.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'pysug', first_name: 'Pacita Noren', last_name: 'Ysug', email: 'noreenysug@gmail.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'nbaguitan', first_name: 'Noel', last_name: 'Baguitan', email: 'noel2jhaz@yahoo.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'jcapati', first_name: 'John Carlo', last_name: 'Capati', email: 'jc_capati23@yahoo.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'pdiaz', first_name: 'Princess', last_name: 'Diaz', email: 'princessdiaz316@gmail.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'gsantos', first_name: 'Gary', last_name: 'Santos', email: 'rfafoix@yahoo.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'etimbaag', first_name: 'Earl-Wyna', last_name: 'Timbaag', email: 'fo9erfrs@gmail.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'amadamba', first_name: 'Almer', last_name: 'Madamba', email: 'almer.madamba@yahoo.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'randuyan', first_name: 'Rowena', last_name: 'Anduyan', email: 'wenanduyan@yahoo.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'mgallor', first_name: 'Marygen', last_name: 'Gallor', email: 'ghen_0331@yahoo.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'mesquierdo', first_name: 'Maria Clarisa', last_name: 'Esquierdo', email: 'cesquierdo@yahoo.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'gborja', first_name: 'George', last_name: 'Borja', email: 'borja_dswd5@yah00.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'alampera', first_name: 'Annaly', last_name: 'Lampera', email: 'annaly_legazpi@yahoo.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'jmartizano', first_name: 'Joe Marie', last_name: 'Martizano', email: 'maritana52682@yahoo.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'wkelly', first_name: 'Warlee', last_name: 'Kelly', email: 'warly_0707@yahoo.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'hbarona', first_name: 'Hazel', last_name: 'Barona', email: 'lezah_xavier@yahoo.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'jruedo', first_name: 'Jennifer', last_name: 'Ruedo', email: 'jruedo@yahoo.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'bbing-il', first_name: 'Benjie', last_name: 'Bing-il', email: 'benjiebing_il@yahoo.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'iroque', first_name: 'Irenea Liza', last_name: 'Roque', email: 'hazil_45@yahoo.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'mreyesiii', first_name: 'Manuel', last_name: 'Reyes III', email: 'manuel_xii@yahoo.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'atamama', first_name: 'Alladin', last_name: 'Tamama', email: 'aladztama@yahoo.com', password: 'password', role_id: 1)
# User.find_or_create_by_username(username: 'eegano', first_name: 'Eruel', last_name: 'Egano', email: 'eruelegano@yahoo.com', password: 'password', role_id: 1)
# puts "Done!!"

puts "Fund Source"
FundSource.find_or_create_by(name: 'Asian Development Bank', code: 'ADB')
FundSource.find_or_create_by(name: 'World Bank', code: 'WB')
puts "Done!!"

puts "Municipal Groups"
Group.find_or_create_by(code: '177', status: 'Active', fund_source_id: 1)
Group.find_or_create_by(code: '293', status: 'Active', fund_source_id: 2)
Group.find_or_create_by(code: '377', status: 'Active')
puts "Done!!"


Rake::Task["barangays:import"].execute
Rake::Task["signatories:import"].execute
Rake::Task["grant_allocation:import"].execute
Rake::Task["fund_allocation:import"].execute
Rake::Task["users:import"].execute

PublicActivity.enabled = true



