require 'nokogiri'
require 'geoip'

# Special thanks to PentestGeek - http://www.pentestgeek.com/2012/08/23/creds-or-hash-where-the-admin-at/

if ARGV.size != 1 then
  puts "n[-] Usage: ./crutch.rb <filename.xml>"
  exit
end

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
