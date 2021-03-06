
namespace :db do
  desc "move all Web Address sorts to type_ids"
  task :fix_web_address_urls => :environment do
    WebAddress.all.select{|a| !a.type.code.eql?("email") && 
                              !a.address.starts_with?('http://') &&
                              !a.address.starts_with?('www.')}.each do |web_address|
      web_address.address = 'http://' + web_address.address
      puts 'Fixed: ' + web_address.address if web_address.save
    end
  end
end