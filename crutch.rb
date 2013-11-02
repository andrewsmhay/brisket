require 'nokogiri'
require 'geoip'

# Special thanks to PentestGeek - http://www.pentestgeek.com/2012/08/23/creds-or-hash-where-the-admin-at/
opt_sel = ['city','country']
opt_sel_err = "[-] Usage: ./crutch.rb <results file> <city|country>"
working_dir = "."
results_dir = working_dir+"/results/"
dir_date = Date.today.year.to_s+"/"+Date.today.month.to_s+"/"+Date.today.day.to_s+"/"
results_dir_date = results_dir + dir_date
item_dir= []
commands = []
ARGV.each {|arg| commands << arg}

puts "[+] Beginning conversion..."
if ARGV[0] == opt_sel[0]
  Dir.foreach(results_dir_date) do |item|
    next if item == '.' or item == '..'
      item_dir << results_dir_date + item
      item_xml = item.gsub(/(.ip)/, '.xml')
    end
elsif ARGV[0] == opt_sel[1]
  europe_reg.shuffle.each do |e|
    system(cmd + " -c " + confpath + e + " --banners --excludefile " + exclude_file)
  end
else puts opt_sel_err
end
puts "[+] Scan complete."

xml = Nokogiri::XML.parse(open ARGV[0])
# diplay which ip address and ports are open
xml.css('nmaprun host').each do |host|
  begin
    target_address = host.css('address').first['addr']
    target_geo = GeoIP.new('GeoLiteCity.dat').city(target_address)
    target_ports = host.css('port').first['portid']
    if host.css('banner').empty?
    	target_banner = 'NULL'
    elsif host.css('banner') =~ /^cert/
      target_banner = 'SSL Certificate'
#    elsif host.css('banner') =~ /(Apache[^\\]*)\\x0d/
#      target_banner = /(Apache[^\\]*)\\x0d/.match(host.css('banner'))
#    elsif host.css('banner') =~ /(nginx[^\\]*)\\x0d/
#      target_banner = host.css('banner')
    else
    	target_banner = host.css('banner')
    end
    #target_banner = host.css('banner')
    puts target_address.to_s + "|" + target_ports.to_s + "|" + target_geo.latitude.to_s+"|"+target_geo.longitude.to_s + "|" + target_banner.to_s.gsub(/<\/*banner>/, '')
  rescue Exception => e
    puts "[-] Error On: #{target_address}"
    next
  end
end
puts "[+] Analysis and conversion complete."